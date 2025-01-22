

import UIKit
import Social

class AAArticleDetailsViewController: AAViewController {

    @IBOutlet weak var articleTable: UITableView!
    @IBOutlet weak var ArticleShareButton: UIButton!
    
    var selectedArticleModel: AAArticleModel?
    let articleDetailsService = AAArticleDetailsService()
    var articleDetails: AAArticleDetailModel?
    var isSearchBased = false
    var isCategoryBased = false
    var isMapBased = false
    var searchString: String?
    let shareService = HEShareService()

    func share(_ view: UIView) {
        shareService.share(view, onViewController: self, havingArticle: articleDetails!)    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isMapBased == true { self.navigationItem.rightBarButtonItem = nil }
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if selectedArticleModel != nil {
            if isSearchBased == true {
                getArticleDetails(selectedArticleModel?.articleId, withSearchText: searchString)
                return
            }
            if isCategoryBased == true {
                getArticleDetails(selectedArticleModel?.articleId)
                return
            }
            else { getArticleDetails(selectedArticleModel?.articleId) }
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getArticleDetails(_ id: String?) {
        showLoaderOnView(self.view)
        articleDetailsService.getArticleDetails(id!, completion: { (details, error) in
            if details != nil {
                DispatchQueue.main.async {
                    self.hideLoaderFromView(self.view)
                    self.articleDetails = details
                    self.articleTable.reloadData()
                }
            }
        })
    }
    
    private func getArticleDetails(_ id: String?, withSearchText text: String?) {
        showLoaderOnView(self.view)
        articleDetailsService.getArticleDetails(id!, withSearchText: searchString, completion: { (details, error) in
            if details != nil {
                DispatchQueue.main.async {
                    self.hideLoaderFromView(self.view)
                    self.articleDetails = details
                    
                    self.articleTable.reloadData()
                }
            }
        })
    }
    
    func getArticleDetailsForMap(_ id: String?) {
        getArticleDetails(id)
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AAArticleDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ArticleDetails.Sections.label.rawValue { return 1 }//no of rows
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
            case ArticleDetails.Sections.image.rawValue:
                let cellId = ArticleDetails.TableViewCellIds.galleryCell
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AAArticleGalleryCell
                cell.populateData(articleDetails, viewController: self)
                return cell
            case ArticleDetails.Sections.label.rawValue:
                let cellId = ArticleDetails.TableViewCellIds.labelCell
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AAArticleLabelCell
                cell.delegate = self
                cell.populateData(articleDetails, atIndexPath: indexPath)
                return cell
            case ArticleDetails.Sections.body.rawValue:
                let cellId = ArticleDetails.TableViewCellIds.bodyCell
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AAArticleBodyCell
                cell.populateData(articleDetails)
                return cell
            default: return UITableViewCell()
        }
    }
}

extension AAArticleDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == ArticleDetails.Sections.label.rawValue { return 100 }
        if indexPath.section == ArticleDetails.Sections.image.rawValue { return 150 }
        return 498
    }
}

extension AAArticleDetailsViewController: AAArticleLabelCellDelegate {
    func shareArticle(_ cell: UITableViewCell) {
        share(cell)
    }
}
