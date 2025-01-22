//
//  AAGalleryViewController.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 25/12/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit
import QuickLook
import SDWebImage

class AAGalleryViewController: AAViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    let articleListService = AAAricleListService()
    let quickLookController = QLPreviewController()
    var articlesArray: [AAArticleModel]?
    var articleListIndex = 1
    var lazyLoadingEnabled = false
    var isInitialLazyLoad = true
    var lazyLoadingInProgress = false
    var numberOfSections = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
        quickLookController.dataSource = self
        getArticleList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticleList() {
        if lazyLoadingInProgress == true { self.insertLazyLoaderSection() }
        else { showLoaderOnView(self.view) }
        
        lazyLoadingEnabled = true
        articleListService.getArticleList(articleListIndex) { (articles, error) in
            DispatchQueue.main.async { self.hideLoaderFromView(self.view) }
            if self.isInitialLazyLoad == false {
                self.lazyLoadingInProgress = false
                self.numberOfSections = 1
                var indexPaths = [IndexPath]()
                for eachArticle in articles! {
                    self.articlesArray?.append(eachArticle)
                    indexPaths.append(IndexPath(row: (self.articlesArray?.count)! - 1, section: 0))
                }
                
                DispatchQueue.main.async {
                    self.collectionView.performBatchUpdates({
                        self.collectionView.deleteSections(IndexSet(integer: 1))
                        self.collectionView.insertItems(at: indexPaths)
                    }, completion: { (finished) in })
                }
                
                self.articleListIndex = (self.articlesArray?.count)!
            } else {
                self.isInitialLazyLoad = false
                self.articlesArray = articles
                if self.articlesArray != nil && (self.articlesArray?.count)! > 0 {
                    self.articleListIndex = (self.articlesArray?.count)!
                }
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        }
    }
    
    func insertLazyLoaderSection() {
        self.numberOfSections = 2
        DispatchQueue.main.async { self.collectionView.insertSections(IndexSet(integer: 1)) }
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
extension AAGalleryViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        if articlesArray == nil || articlesArray?.count == 0 { return 0 }
        return (articlesArray?.count)!
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let article = articlesArray![index]
        let imageurl = imageUrl + (article.articleId)! + ".jpg"
        let cachePath = SDImageCache.shared().defaultCachePath(forKey: imageurl) ?? ""
        return (URL(fileURLWithPath: cachePath) as QLPreviewItem?)!
    }
}

extension AAGalleryViewController: QLPreviewControllerDelegate {
    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return true
    }
}

extension AAGalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return (articlesArray == nil) ? 0 : (articlesArray?.count)! }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cellId = ArticleDetails.CollectionViewCellIds.imageCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AAArticleImageCell
            cell.populateData(articlesArray?[indexPath.item])
            
            if lazyLoadingEnabled == true {
                if indexPath.row == (articlesArray?.count)! - 1
                    && lazyLoadingInProgress == false  {
                    lazyLoadingInProgress = true
                    getArticleList()
                }
            }
            
            return cell
        } else {
            let cellId = ArticleDetails.CollectionViewCellIds.loaderCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            return cell
        }
    }
}

extension AAGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articlesArray![indexPath.item]
        let imageurl = imageUrl + (article.articleId)! + ".jpg"
        if QLPreviewController.canPreview(URL(string: imageurl)! as QLPreviewItem) {
            quickLookController.currentPreviewItemIndex = indexPath.item
            navigationController?.pushViewController(quickLookController, animated: true)
        }
    }
}

extension AAGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 60, height: 60)
    }
}
