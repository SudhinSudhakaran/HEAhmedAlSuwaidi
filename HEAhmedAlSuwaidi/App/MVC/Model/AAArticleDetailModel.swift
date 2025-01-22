//
//  AAArticleDetailModel.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 12/11/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit

class AAArticleDetailModel: NSObject {
    var articleId: String?
    var articleName: String?
    var articleBody: String?
    var articleDate: String?
    var articleCategory: String?
    var articleCategoryName: String?
    var articlePlace: String?
    var articlePlaceName: String?
    var articleNewspaper: String?
    var articleNewspaperName: String?
    var articleJournalist: String?
    var articlePeople: String?
    var articlePhotoIcon: String?
    var articlePaperPhoto: String?
    var articlePhoto1: String?
    var articlePhoto2: String?
    var articlePhoto3: String?
    
    
    
    init(_ article: [String: Any]) {
        super.init()
        
        self.articleId = article["id"] as? String
        self.articleName = article["name"] as? String
        self.articleBody = article["body"] as? String
        self.articleDate = article["eventdate"] as? String
        self.articleCategory = article["category"] as? String
        self.articleCategoryName = article["categoryname"] as? String
        self.articlePlace = article["place"] as? String
        self.articlePlaceName = article["placename"] as? String
        self.articleNewspaper = article["newspaper"] as? String
        self.articleNewspaperName = article["newspapername"] as? String
        self.articleJournalist = article["journalist"] as? String
        self.articlePeople = article["people"] as? String
        self.articlePhotoIcon = article["photoicon"] as? String
        self.articlePaperPhoto = article["newspaperphoto"] as? String
        self.articlePhoto1 = article["photo1"] as? String
        self.articlePhoto2 = article["photo2"] as? String
        self.articlePhoto3 = article["photo3"] as? String
        
    }
}
