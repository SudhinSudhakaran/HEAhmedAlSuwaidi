//
//  AAArticleLabelCell.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 12/11/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit

protocol AAArticleLabelCellDelegate {
    func shareArticle(_ cell: UITableViewCell)
}

class AAArticleLabelCell: UITableViewCell {

    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    var delegate: AAArticleLabelCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButtonTapped(_ sender: Any?) {
        delegate?.shareArticle(self)
    }
    
    func populateData(_ article: AAArticleDetailModel?, atIndexPath indexPath: IndexPath) {
        if article != nil {
            switch indexPath.row {
            case ArticleDetails.Rows.name.rawValue:
                self.mainTitle.text = article?.articleName
                self.subTitle.text  = article?.articleDate
                
            //case ArticleDetails.Rows.category.rawValue:
           //     self.mainTitle.text = "الموضوع : "+(article?.articleCategoryName)!
          //      self.subTitle.text  = "المكان : "+(article?.articlePlaceName)!
                
         //   case ArticleDetails.Rows.newspaper.rawValue:
         //       self.mainTitle.text = "الجريدة : "+(article?.articleNewspaperName)!
         //       self.subTitle.text  = article?.articleJournalist
                
            //case ArticleDetails.Rows.people.rawValue:
               // self.mainTitle.text = article?.articlePeople
              //  self.subTitle.text  = ""
                
            default:
                self.mainTitle.text = article?.articleName
            }
        }
    }
}
