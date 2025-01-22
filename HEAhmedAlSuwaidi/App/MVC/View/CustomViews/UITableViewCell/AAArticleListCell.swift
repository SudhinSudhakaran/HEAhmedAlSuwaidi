
import UIKit
import SDWebImage

class AAArticleListCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleEventdate: UILabel!
    @IBOutlet weak var premiumBadge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(_ article: AAArticleModel?) {
        if article != nil {
            articleName.text      = article?.articleName;
            articleEventdate.text = article?.eventDate;
            
            if article?.isPaid == true {
                premiumBadge.isHidden = false
            } else {
                premiumBadge.isHidden = true
            }
            
            let imageurl = imageUrl + (article?.articleId)! + ".jpg";
            articleImage.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "placeholder_img"));
        }
    }
}
