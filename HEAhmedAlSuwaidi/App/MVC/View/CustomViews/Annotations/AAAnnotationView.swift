

import UIKit
import MapKit

class AAAnnotationView: MKAnnotationView {
    var imageView: UIImageView?
    var pinImageView: UIImageView?
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 80, height: 60))
        self.pinImageView = UIImageView(frame: CGRect(x: (self.imageView?.frame.minX)! - 42, y: (self.imageView?.frame.minY)! - 30, width: 40, height: 40))
        self.imageView?.contentMode = .scaleAspectFit
        self.pinImageView?.contentMode = .scaleAspectFit
        self.pinImageView?.image = UIImage(named: "pin")
        self.addSubview(imageView!)
        self.imageView?.addSubview(pinImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerOffset = CGPoint(x: 10, y: -16)
    }
    func updateAnnotationData(_ place: AAPlaceListModel?) {
        if place != nil {
            let imageurl = imageUrl + "places/" + (place?.placeId)! + ".jpg";
            imageView?.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "placeholder_img"));
        }
    }
}
