//
//  AAAppConstants.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 31/10/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import Foundation

let menuItems = ["About His Excellency",
                 "Archives List",
                 "Archives Mapped",
                 "Archives By Year",
                 "Archives By Places",
                 "Archives By Newspaper",
                 "Archives By Category",
                 "Search By Event Date",
                 "Speech Search",
                 "Gallery"]

enum LeftMenuOptions: Int {
    case abouthea = 0
    case viewOnList
    case viewOnMap
    case articlesByYear
    case articlesByPlace
    case articlesByNewspaper
    case articlesByCategory
    case searchbyeventdate
    case speechsearch
    case gallery
}

enum CategoryOptions: Int {
    case byYear = 0
    case byNewsPaper
    case byPlace
    case byCategory
    case byEventDate
    case none
}

//var t_people   = ""
//var languageid = 1 //1 for arabic and 2 for english

//switch languageid{
//case 2   : t_people   = "People"
//default  : t_people   = "Peoplarabic"
//}
