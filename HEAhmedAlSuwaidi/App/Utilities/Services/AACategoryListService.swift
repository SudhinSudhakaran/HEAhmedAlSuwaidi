//
//  AACategoryListService.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 25/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class AACategoryListService: NSObject {
    let categoryByYear  = "hea_json_articlesByyearlist.php"
    let categoryByPlace = "hea_json_articlesByplacelist.php"
    let categoryByNewspaper = "hea_json_articlesBynewspaperlist.php"
    let categoryByCategory = "hea_json_articlesBycategorylist.php"
    
    public func getCategoryByYear(_ completion: @escaping (([AACategoryModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + categoryByYear, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let categoryList = responseDictionary?["years"] as? [[String: Any]] {
                            var categoryArray = [AACategoryModel]()
                            for eachCategory in categoryList {
                                categoryArray.append(AACategoryModel(eachCategory))
                            }
                            completion(categoryArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
        
        
    }
    
    
    public func getCategoryByPlace(_ completion: @escaping (([AACategoryModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + categoryByPlace, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let categoryList = responseDictionary?["places"] as? [[String: Any]] {
                            var categoryArray = [AACategoryModel]()
                            for eachCategory in categoryList {
                                categoryArray.append(AACategoryModel(eachCategory))
                            }
                            completion(categoryArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getCategoryByNewspaper(_ completion: @escaping (([AACategoryModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + categoryByNewspaper, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let categoryList = responseDictionary?["newspapers"] as? [[String: Any]] {
                            var categoryArray = [AACategoryModel]()
                            for eachCategory in categoryList {
                                categoryArray.append(AACategoryModel(eachCategory))
                            }
                            completion(categoryArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
        
        
    }
    
    public func getCategoryByCategory(_ completion: @escaping (([AACategoryModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + categoryByCategory, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let categoryList = responseDictionary?["categories"] as? [[String: Any]] {
                            var categoryArray = [AACategoryModel]()
                            for eachCategory in categoryList {
                                categoryArray.append(AACategoryModel(eachCategory))
                            }
                            completion(categoryArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
        
        
    }
}
