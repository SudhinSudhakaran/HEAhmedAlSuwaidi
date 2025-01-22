//
//  AACategoryArticleModel.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 25/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class AACategoryArticleModel: NSObject {
    var articleId: String?
    var articleName: String?
    var eventDate: String?
    var photoIcon: String?
    var isPaid: Bool?
    
    init(_ article: [String: Any]) {
        super.init()
        
        self.articleId = article["articleid"] as? String
        self.articleName = article["articlename"] as? String
        self.eventDate = article["eventdate"] as? String
        self.photoIcon = article["photoicon"] as? String
        
        let bdge = article["inapp_paid"] as? String
        if bdge == "1" {
            self.isPaid = true
        } else {
            self.isPaid = false
        }
    }
}
