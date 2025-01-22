
import UIKit
import QuickLook
import SDWebImage

class AAArticleGalleryCell: UITableViewCell {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var images: [URL]?
    let quickLookController = QLPreviewController()
    var parentViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quickLookController.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(_ article: AAArticleDetailModel?, viewController controller: UIViewController) {
        parentViewController = controller
        if article != nil {
            images = [URL]()
            if article?.articlePhotoIcon == "1" {
                let imageName = (article?.articleId)! + ".jpg"
                let imageurl = imageUrl + imageName
                images?.append(URL(string: imageurl)!)
            }
            if article?.articlePaperPhoto == "1" {
                let imageName = (article?.articleId)! + "-n.jpg"
                let imageurl = imageUrl + imageName
                images?.append(URL(string: imageurl)!)
            }
            if article?.articlePhoto1 == "1" {
                let imageName = (article?.articleId)! + "-1.jpg"
                let imageurl = imageUrl + imageName
                images?.append(URL(string: imageurl)!)
            }
            if article?.articlePhoto2 == "1" {
                let imageName = (article?.articleId)! + "-2.jpg"
                let imageurl = imageUrl + imageName
                images?.append(URL(string: imageurl)!)
            }
            if article?.articlePhoto3 == "1" {
                let imageName = (article?.articleId)! + "-3.jpg"
                let imageurl = imageUrl + imageName
                images?.append(URL(string: imageurl)!)
            }
            
            galleryCollectionView.reloadData()
        }
    }
}

extension AAArticleGalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images == nil || images?.count == 0 { return 0 }
        return (images?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = ArticleDetails.CollectionViewCellIds.imageCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AAArticleImageCell
        cell.showImage(images?[indexPath.item])
        return cell
    }
}

extension AAArticleGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if images != nil || (images?.count)! > 0 {
            let width = Int(self.bounds.width) / (images?.count)!
            return CGSize(width: CGFloat(width), height: self.bounds.height)
        }
        return CGSize(width: 100, height: self.bounds.height)
    }
}

extension AAArticleGalleryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if QLPreviewController.canPreview(images![indexPath.item] as QLPreviewItem) {
            quickLookController.currentPreviewItemIndex = indexPath.item
            parentViewController?.navigationController?.pushViewController(quickLookController, animated: true)
        }
    }
}

extension AAArticleGalleryCell: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        if images == nil || images?.count == 0 { return 0 }
        return (images?.count)!
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = images?[index].absoluteString
        let cachePath = SDImageCache.shared().defaultCachePath(forKey: url) ?? ""
        return (URL(fileURLWithPath: cachePath) as QLPreviewItem?)!
    }
}

extension AAArticleGalleryCell: QLPreviewControllerDelegate {
    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return true
    }
}
