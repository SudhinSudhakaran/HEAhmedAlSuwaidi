//
//  AAPlaceListModel.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 05/11/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import MapKit

class AAPlaceListModel: NSObject {
    var placeId: String?
    var placeEn: String?
    var placeAr: String?
    var coordinate: CLLocationCoordinate2D?
    
    init(_ place: [String: Any]) {
        super.init()
        
        self.placeId = place["id"] as? String
        self.placeEn = place["place_2"] as? String
        self.placeAr = place["place_1"] as? String
        
        let lat = Double(place["latitude"] as! String)
        let lon = Double(place["longitude"] as! String)
        
        self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
    }
}
