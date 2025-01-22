//
//  AAArticleModel.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 31/10/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import MapKit

class AAArticleModel: NSObject {
    var articleId: String?
    var articleName: String?
    var eventDate: String?
    var category: String?
    var newspaper: String?
    var place: String?
    var people: String?
    var journalist: String?
    var photoicon: String?
    var newspaperphoto: String?
    var isPaid: Bool?
    var coordinate: CLLocationCoordinate2D?
    
    init(_ article: [String: Any]) {
        super.init()
        
        self.articleId = article["id"] as? String
        self.articleName = article["name"] as? String
        self.eventDate = article["eventdate"] as? String
        self.category = article["category"] as? String
        self.newspaper = article["newspaper"] as? String
        self.place = article["place"] as? String
        self.people = article["people"] as? String
        self.journalist = article["journalist"] as? String
        self.photoicon = article["photoicon"] as? String
        self.newspaperphoto = article["newspaperphoto"] as? String
        
        let bdge = article["inapp_paid"] as? String
        if bdge == "1" {
            self.isPaid = true
        } else {
            self.isPaid = false
        }
        
        if article["latitude"] != nil && article["longitude"] != nil {
            let lat = Double(article["latitude"] as! String)
            let lon = Double(article["longitude"] as! String)
            
            self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        }
    }
}


