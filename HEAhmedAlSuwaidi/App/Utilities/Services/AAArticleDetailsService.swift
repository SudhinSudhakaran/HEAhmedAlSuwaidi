//
//  AAArticleDetailsService.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 12/11/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit

class AAArticleDetailsService: NSObject {
    let apiPath = "hea_json_article.php?articleid="
    let apiPathForSearch = "hea_json_article.php?articleid="
    let searhOption = "&searchtext="
    
    public func getArticleDetails(_ id: String, completion: @escaping ((AAArticleDetailModel?, Error?) -> ())) {
        let url = apiUrl + apiPath + id
        
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articles = responseDictionary?["articles"] as? [[String: Any]] {
                            let articleDetails = AAArticleDetailModel(articles[0])
                            completion(articleDetails, nil)
                        } else { completion(nil, nil) }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    public func getArticleDetails(_ id: String, withSearchText text: String?, completion: @escaping ((AAArticleDetailModel?, Error?) -> ())) {
        let url = apiUrl + apiPathForSearch + id + searhOption + text!.toBase64()
        //print (url)
        //let url = apiUrl + apiPath + id
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articles = responseDictionary?["articles"] as? [[String: Any]] {
                            let articleDetails = AAArticleDetailModel(articles[0])
                            completion(articleDetails, nil)
                        } else { completion(nil, nil) }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
