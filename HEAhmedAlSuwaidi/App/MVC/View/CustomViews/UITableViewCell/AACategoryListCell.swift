

import UIKit

protocol AACategoryListCellDelegate {
    func categorySelected(_ category: AACategoryModel?)
    func articleSelected(_ article: AACategoryArticleModel?)
}

class AACategoryListCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    var articles: [AACategoryArticleModel]?
    var currentCategory: AACategoryModel?
    var delegate: AACategoryListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(_ category: AACategoryModel?) {
        currentCategory = category
        if category != nil {
            //categoryTitle.text = (category?.categoryId)! + " : " + (category?.categoryIdName)!
            categoryTitle.text = (category?.categoryIdName)! + " < View All" 
            articles = category?.articles
            collectionView.reloadData()
        }
    }
    
    @IBAction func categorySelected(_ sender: Any) {
        delegate?.categorySelected(currentCategory)
    }
}

extension AACategoryListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if articles != nil && (articles?.count)! > 0 { return (articles?.count)! }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemCell", for: indexPath) as? AACategoryItemCell
        let categoryItem = articles![indexPath.item]
        cell?.populateData(categoryItem)
        return cell!
    }
}

extension AACategoryListCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentCategory != nil && (currentCategory?.articles?.count)! > 0 {
            let article = currentCategory?.articles![indexPath.item]
            delegate?.articleSelected(article)
        }
    }
}

extension AACategoryListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 298.0)
    }
}
