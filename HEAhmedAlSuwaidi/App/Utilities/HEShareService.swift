//
//  HEShareService.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 17/12/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class HEShareService: NSObject {
    var shareItems = [Any]()

    var img1Downloaded = false
    var img2Downloaded = false
    var img3Downloaded = false
    var img4Downloaded = false
    var img5Downloaded = false
    
    func initialize() {
        shareItems = [Any]()
        img1Downloaded = false
        img2Downloaded = false
        img3Downloaded = false
        img4Downloaded = false
        img5Downloaded = false
    }
    
    func share(_ view: UIView, onViewController controller: AAViewController, havingArticle article: AAArticleDetailModel) {
        initialize()
        
        var shareItem = article.articleBody
        var str = shareItem?.replacingOccurrences(of: "<br>", with: "\n", options: .regularExpression, range: nil)
        str = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        shareItem = (article.articleName)!
                        + "\n"
                        + (article.articleDate)!
                        + "\nالمكان : "
                        + (article.articlePlaceName)!
                        + "\nالجريدة : "
                        + (article.articleNewspaperName)!
                        + "\n"
                        + (article.articleJournalist)!
                        + "\nأشخاص : \n"
                        + (article.articlePeople)!
                        + "\n"
                        + str!
        
        UIPasteboard.general.string = shareItem
        shareItems.append(shareItem!)
        controller.showLoaderOnView(view)
        
        let imgUrl1 = URL(string: imageUrl + article.articleId! + "-n.jpg")
        let imgUrl2 = URL(string: imageUrl + article.articleId! + "-1.jpg")
        let imgUrl3 = URL(string: imageUrl + article.articleId! + "-2.jpg")
        let imgUrl4 = URL(string: imageUrl + article.articleId! + "-3.jpg")
        let imgUrl5 = URL(string: imageUrl + article.articleId! + ".jpg")
        
        HEImageDownloadService().download(imgUrl1!) { (image, error) in
            self.img1Downloaded = true
            if image != nil { self.shareItems.append(image!) }
            self.checkForCompletion(view, onViewController: controller, withItem: self.shareItems)
        }
        HEImageDownloadService().download(imgUrl2!) { (image, error) in
            self.img2Downloaded = true
            if image != nil { self.shareItems.append(image!) }
            self.checkForCompletion(view, onViewController: controller, withItem: self.shareItems)
        }
        HEImageDownloadService().download(imgUrl3!) { (image, error) in
            self.img3Downloaded = true
            if image != nil { self.shareItems.append(image!) }
            self.checkForCompletion(view, onViewController: controller, withItem: self.shareItems)
        }
        HEImageDownloadService().download(imgUrl4!) { (image, error) in
            self.img4Downloaded = true
            if image != nil { self.shareItems.append(image!) }
            self.checkForCompletion(view, onViewController: controller, withItem: self.shareItems)
        }
        HEImageDownloadService().download(imgUrl5!) { (image, error) in
            self.img5Downloaded = true
            if image != nil { self.shareItems.append(image!) }
            self.checkForCompletion(view, onViewController: controller, withItem: self.shareItems)
        }
    }
    
    func checkForCompletion(_ view: UIView, onViewController controller: AAViewController, withItem items: [Any]) {
        if img1Downloaded == true
            && img2Downloaded == true
            && img3Downloaded == true
            && img4Downloaded == true
            && img5Downloaded == true{
            DispatchQueue.main.async() {
                controller.hideLoaderFromView(view)
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = view
                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.unknown
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                controller.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}
