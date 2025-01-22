

import UIKit
import MapKit
import WebKit

class AAPlacesViewController: AAViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var callOutView: UIView!
    
    let placesService = AAPlaceListService()
    let articleDetailsService = AAArticleDetailsService()
    var placesArray: [AAPlaceListModel]?
    var selectedPlace: AAPlaceListModel?
    var dashboard: AADashboardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        callOutView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width - 50, height: self.view.frame.height - 50)
        self.view.addSubview(callOutView)
        getPlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getPlaces() {
        showLoaderOnView(self.view)
        placesService.getPlaceList { (places, error) in
            self.placesArray = places
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                var annotations = [AAAnnotation]()
                for eachPlace in places! {
                    let anntn = self.annotation(eachPlace.coordinate, withPlace: eachPlace)
                    annotations.append(anntn)
                }
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    private func annotation(_ cordinate: CLLocationCoordinate2D?, withPlace place: AAPlaceListModel) -> AAAnnotation {
        let annotation = AAAnnotation(coordinate: cordinate!)
        annotation.place = place
        mapView.addAnnotation(annotation)
        
        var span = MKCoordinateSpan()
        span.latitudeDelta = 3.0
        span.longitudeDelta = 3.0
        
        var region = MKCoordinateRegion()
        region.span = span
        region.center = cordinate!
        mapView.setRegion(region, animated: true)
        
        return annotation
    }
    
    //SHOWING POP UP FOR ARTICLES DETAILS ON MAP
    private func showCallOut(_ id: String?){
        callOutView.alpha = 0
        callOutView.frame = self.view.bounds
        
        let category = AACategoryModel(nil)
        category.categoryId = selectedPlace?.placeId
        dashboard?.selectedCategory = category
        dashboard?.loadData()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.callOutView.alpha = 1
        })
    }
    
    @IBAction func callOutGestureSelected(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.callOutView.alpha = 0
        }) { (success) in
            self.callOutView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as? UINavigationController
        navigationController?.popViewController(animated: false)
        dashboard = navigationController?.topViewController as? AADashboardViewController
        dashboard?.categoryOption = .byPlace
        dashboard?.isMapBased = true
    }
}

extension AAPlacesViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: AAAnnotationView?
        
        if let currentAnnotation = annotation as? AAAnnotation {
            let annotationId = "annotation"
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? AAAnnotationView
            
            if annotationView == nil {
                annotationView = AAAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            }
            
            var annotationViewFrame = annotationView?.bounds
            annotationViewFrame?.size.width = (annotationView?.bounds.width)! + 100.0
            annotationViewFrame?.size.height = (annotationView?.bounds.height)! + 100.0
            annotationView?.frame = annotationViewFrame!
            
            annotationView?.updateAnnotationData(currentAnnotation.place)
            annotationView?.imageView?.center = (annotationView?.center)!
            return annotationView
        }
        return nil
    }
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        if let annotation = view.annotation as? AAAnnotation {
            selectedPlace = annotation.place
            print("tanura : "+(selectedPlace?.placeId)!);
            self.showCallOut(selectedPlace?.placeId)
        }
    }
}
