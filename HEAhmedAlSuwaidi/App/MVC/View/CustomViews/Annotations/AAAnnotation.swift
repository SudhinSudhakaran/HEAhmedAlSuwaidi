//
//  AAAnnotation.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 05/11/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import MapKit

class AAAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var place: AAPlaceListModel?
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
