//
//  AAArticleImageCell.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 18/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit
import SDWebImage

class AAArticleImageCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    func showImage(_ url: URL?) {
        image.image = UIImage(named: "placeholder_img")
        image.sd_setImage(with: url) { (image, error, cacheType, url) in
            SDImageCache.shared().store(image, forKey: url?.absoluteString, completion: { })
        }
    }
    
    func populateData(_ article: AAArticleModel?) {
        let imageurl = imageUrl + (article?.articleId)! + ".jpg"
        image.image = UIImage(named: "placeholder_img")
        image.sd_setImage(with: URL(string: imageurl)) { (image, error, cacheType, url) in
            SDImageCache.shared().store(image, forKey: imageurl, completion: { })
        }
    }
}
