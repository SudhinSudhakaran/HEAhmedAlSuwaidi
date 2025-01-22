

import UIKit

class AACategoryItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var premiumBadge: UIImageView!
    
    func populateData(_ article: AACategoryArticleModel?) {
        if article != nil {
            imageView.contentMode = .scaleToFill
            if article?.isPaid == true {
                premiumBadge.isHidden = false
            } else {
                premiumBadge.isHidden = true
            }
            let imageurl = imageUrl + (article?.articleId)! + ".jpg";
            imageView.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "placeholder_img"))
        }
    }
}
