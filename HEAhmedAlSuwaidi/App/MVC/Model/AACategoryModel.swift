//
//  AACategoryModel.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 25/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class AACategoryModel: NSObject {
    var categoryId: String?
    var categoryIdName: String?
    var articles: [AACategoryArticleModel]?
    
    init(_ category: [String: Any]?) {
        super.init()
        
        self.categoryId = category?["id"] as? String
        self.categoryIdName = category?["name"] as? String
        if let articleList = category?["articles"] as? [[String: String]] {
            articles = [AACategoryArticleModel]()
            for eachArticle in articleList {
                articles?.append(AACategoryArticleModel(eachArticle))
            }
        }
    }
}

