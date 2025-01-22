

import UIKit

class AAAricleListService: NSObject {
    let apiPath = "hea_json_articlelist.php?begin="
    public func getArticleList(_ startIndex: Int, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + apiPath + "\(startIndex)", parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getArticleListByYear(_ year: String?, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        let url = apiUrl + apiPath + "&year=" + year!
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getArticleListByPlace(_ year: String?, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        let url = apiUrl + apiPath + "&placeid=" + year!
        print (url)
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getArticleListByNewspaper(_ year: String?, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        let url = apiUrl + apiPath + "&newspaperid=" + year!
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getArticleListByCategory(_ year: String?, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        let url = apiUrl + apiPath + "&articlecategoryid=" + year!
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    public func getArticleListByEventDate(_ year: String?, completion: @escaping (([AAArticleModel]?, Error?) -> ())) {
        let url = apiUrl + apiPath + "&eventdate=" + year!
        print (url)
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["articles"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                            }
                            completion(articleArray, nil)
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
