

import Foundation

enum Dashboard {
    enum TableViewCellIds {
        static let articleCell = "ArticleCell"
        static let categoryCell = "CategoryListCell"
        static let loadingCell = "LoadingCell"
        static let subscriptionCell = "SubscriptionCell"
        static let subscriptioRestorenCell = "SubscriptionRestoreCell"
        static let subscriptionCancelCell = "SubscriptionCancelCell"
    }
}

enum ArticleDetails {
    enum TableViewCellIds {
        static let labelCell = "LabelCell"
        static let galleryCell = "GalleryCell"
        static let bodyCell = "BodyCell"
    }
    enum Sections: Int {
        
        case image = 0
        case label 
        case body
    }
    enum Rows: Int {
        case name      = 0 //name,eventdate
        case category //category,place
        case newspaper  //newspaper,journalist
        case people  //people
    }
    
    enum CollectionViewCellIds {
        static let imageCell = "ImageCell"
        static let loaderCell = "LoaderCell"
    }
}

enum LeftMenu {
    enum TableViewCellIds {
        static let menuCell = "MenuCell"
    }
}
