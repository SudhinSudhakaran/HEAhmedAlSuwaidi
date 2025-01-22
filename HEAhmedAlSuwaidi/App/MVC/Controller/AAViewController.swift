
import UIKit

class AAViewController: UIViewController {
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    lazy var searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addSearchButton() {
        self.navigationItem.setRightBarButtonItems([searchButton], animated: true)
    }
    
    func showLoaderOnView(_ view: UIView) {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    func hideLoaderFromView(_ view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    @objc func searchButtonTapped() {
        searchBar.placeholder = "Search here"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let searchItem = UIBarButtonItem(customView:searchBar)
        self.navigationItem.setRightBarButtonItems([searchItem], animated: true)
    }
    
    @objc func cancelSelected() {
        addSearchButton()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == StoryboardIds.Search.search {
            let searchVC = segue.destination as? AASearchViewController
            searchVC?.searchString = searchBar.text
        }
         */
    }
}

extension AAViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let storyboard = UIStoryboard(name: StoryboardNames.Dashboard.main, bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: StoryboardIds.Dashboard.dashboard) as? AADashboardViewController
        dashboardVC?.searchString = searchBar.text
        dashboardVC?.isSearchBased = true
        self.navigationController?.pushViewController(dashboardVC!, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSelected()
    }
}
