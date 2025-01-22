
import UIKit

class AADashboardViewController: AAViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuContainerLeading: NSLayoutConstraint!
    // MARK: - Private variables
    let articleListService = AAAricleListService()
    let searchService = AASearchService()
    var articlesArray: [AAArticleModel]?
    var leftMenuViewController: AALeftMenuViewController?
    var selectedArticleModel: AAArticleModel?
    var menuVisible = false
    var searchString: String?
    var isSearchBased = false
    var isCategoryBased = false
    var isMapBased = false
    var categoryOption: CategoryOptions = .none
    var selectedCategory: AACategoryModel?
    var currentLeftMenuOption: LeftMenuOptions?
    var isSearchEventDateBased = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var articleListIndex = 1
    var lazyLoadingEnabled = false
    var isInitialLazyLoad = true
    var lazyLoadingInProgress = false
    var additionalCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Archives"
                
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationReceived(notification:)), name: NSNotification.Name(rawValue: "SomeNotificationAct"), object: nil)
        
        if appDelegate.pushNotificationReceived == true {
            pushNotificationReceived(notification: nil)
        } else {
            if isCategoryBased == true { self.navigationItem.leftBarButtonItem = nil }
            if isMapBased == true { self.navigationItem.rightBarButtonItem = nil }
            else { loadData() }
        }
    }
    
    @objc func pushNotificationReceived(notification: NSNotification?){
        let eventdatestring = appDelegate.eventdate
        appDelegate.pushNotificationReceived = false
        showLoaderOnView(self.view)
        articleListService.getArticleListByEventDate(eventdatestring) { (articles, error) in
            self.articlesArray = articles
            
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        if isSearchEventDateBased == true {
            tableView.reloadData()
            return
        }
        
        if isSearchBased == true { getSearchResult()
            return
        }
        
        if isMapBased == true { getArticleListByPlace() }
        else if isCategoryBased == true {
            if selectedCategory == nil { getArticleList() }
            switch categoryOption {
                case .byYear: getArticleListByYear()
                case .byNewsPaper: getArticleListByNewspaper()
                case .byPlace: getArticleListByPlace()
                case .byCategory: getArticleListByCategory()
                case .byEventDate: getArticleListByEventDate()
                default: print("Invalid")
            }
        }
        else { getArticleList() }
    }
    
    func getArticleList() {
        showLoaderOnView(self.view)
        lazyLoadingEnabled = true
        articleListService.getArticleList(articleListIndex) { (articles, error) in
            DispatchQueue.main.async { self.hideLoaderFromView(self.view) }
            if self.isInitialLazyLoad == false {
                self.lazyLoadingInProgress = false
                var indexPaths = [IndexPath]()
                for eachArticle in articles! {
                    self.articlesArray?.append(eachArticle)
                    indexPaths.append(IndexPath(row: (self.articlesArray?.count)! - 1, section: 0))
                }
                
                DispatchQueue.main.async {
                    self.tableView.performBatchUpdates({
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: indexPaths, with: .fade)
                        self.tableView.endUpdates()
                    }, completion: { (finished) in })
                }
                
                self.articleListIndex = (self.articlesArray?.count)!
            } else {
                self.isInitialLazyLoad = false
                self.articlesArray = articles
                if self.articlesArray != nil && (self.articlesArray?.count)! > 0 {
                    self.articleListIndex = (self.articlesArray?.count)!
                }
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
    }
    
    func getArticleListByYear() {
        showLoaderOnView(self.view)
        articleListService.getArticleListByYear(selectedCategory?.categoryId) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    
    func getArticleListByPlace() {
        showLoaderOnView(self.view)
        articleListService.getArticleListByPlace(selectedCategory?.categoryId) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    func getArticleListByNewspaper() {
        showLoaderOnView(self.view)
        articleListService.getArticleListByNewspaper(selectedCategory?.categoryId) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    
    func getArticleListByCategory() {
        showLoaderOnView(self.view)
        articleListService.getArticleListByCategory(selectedCategory?.categoryId) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    func getArticleListByEventDate() {
        showLoaderOnView(self.view)
        articleListService.getArticleListByEventDate(selectedCategory?.categoryId) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    
    func getSearchResult() {
        showLoaderOnView(self.view)
        searchService.getSearchResult(searchString) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableView.reloadData()
            }
        }
    }
    
    func insertLazyLoaderSection() {
        self.additionalCell = 1
        DispatchQueue.main.async {
            self.tableView.performBatchUpdates({
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: (self.articlesArray?.count)!, section: 0)], with: .fade)
                self.tableView.endUpdates()
            }, completion: { (finished) in })
        }
    }

    // MARK: - IBActions
    @IBAction func menuButtonTapped(_ sender: Any?) {
        if menuVisible == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.menuContainerLeading.constant = -(self.menuContainer.frame.width)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.menuContainerLeading.constant = 0
            })
        }
        menuVisible = !menuVisible
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardIds.Dashboard.leftMenu {
            leftMenuViewController = segue.destination as? AALeftMenuViewController
            leftMenuViewController?.delegate = self
        }
        if segue.identifier == StoryboardIds.Dashboard.articleDetails {
            let articleDetails = segue.destination as? AAArticleDetailsViewController
            articleDetails?.selectedArticleModel = selectedArticleModel
            articleDetails?.isSearchBased = isSearchBased
            articleDetails?.isMapBased = isMapBased
            articleDetails?.searchString = searchString
        }
        if segue.identifier == StoryboardIds.Dashboard.categoryList {
            let categoryList = segue.destination as? AACategoryListViewController
            categoryList?.leftMenuOption = currentLeftMenuOption
        }
        if segue.identifier == StoryboardIds.Dashboard.subscription {
            let subscrptn = segue.destination as? AASubscriptionViewController
            subscrptn?.isMapBased = isMapBased
        }
    }
}

extension AADashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (articlesArray == nil) ? 0 : (articlesArray?.count)! + additionalCell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Dashboard.TableViewCellIds.articleCell) as? AAArticleListCell
        cell?.populateData(articlesArray?[indexPath.row])
        
        if lazyLoadingEnabled == true {
            if indexPath.row == (articlesArray?.count)! - 1
                && lazyLoadingInProgress == false
                && isMapBased == false
                && isCategoryBased == false
                && isSearchBased == false {
                lazyLoadingInProgress = true
                getArticleList()
            }
        }
        return cell!
    }
}

extension AADashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticleModel = articlesArray?[indexPath.row]
        if selectedArticleModel?.isPaid == true {
            if UserDefaults.standard.bool(forKey: "purchased") == true {
                performSegue(withIdentifier: StoryboardIds.Dashboard.articleDetails, sender: nil)
            } else {
                performSegue(withIdentifier: StoryboardIds.Dashboard.subscription, sender: nil)
            }
        } else {
            performSegue(withIdentifier: StoryboardIds.Dashboard.articleDetails, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 334
    }
}

extension AADashboardViewController: AALeftMenuViewControllerDelegate {
    func menuViewController(_ controller: AALeftMenuViewController, selectedOption option: LeftMenuOptions) {
        currentLeftMenuOption = option
        switch option {
            case .abouthea:
                performSegue(withIdentifier: StoryboardIds.Dashboard.HeaAbout, sender: nil)
            case .viewOnMap:
                performSegue(withIdentifier: StoryboardIds.Dashboard.viewOnMap, sender: nil)
            case .viewOnList:
                self.navigationController?.popToRootViewController(animated: true)
            case .articlesByYear:
                performSegue(withIdentifier: StoryboardIds.Dashboard.categoryList, sender: nil)
            case .articlesByPlace:
                performSegue(withIdentifier: StoryboardIds.Dashboard.categoryList, sender: nil)
            case .articlesByNewspaper:
                performSegue(withIdentifier: StoryboardIds.Dashboard.categoryList, sender: nil)
            case .articlesByCategory:
                performSegue(withIdentifier: StoryboardIds.Dashboard.categoryList, sender: nil)
            case .searchbyeventdate:
                performSegue(withIdentifier: StoryboardIds.Dashboard.calendar, sender: nil)
            case .speechsearch:
                performSegue(withIdentifier: StoryboardIds.Dashboard.search, sender: nil)
            case .gallery:
                performSegue(withIdentifier: StoryboardIds.Dashboard.gallery, sender: nil)
        }
        menuButtonTapped(nil)
    }
}

