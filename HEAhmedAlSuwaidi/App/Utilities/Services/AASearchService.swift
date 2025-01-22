

import UIKit

class AASearchService: NSObject {
    let apiPath = "Corehe/search/hea_jquery_search?option=1&searchtext="
    let options = "&offset=1&WordForm=1&languageid=1"
    public func getSearchResult(_ searchText: String?, complettionWith completion: @escaping (([AAArticleModel]?, Error?) -> ())) {

        let url = apiUrl + apiPath + searchText!.toBase64() + options
        AANetworkManager.request(url: url, parameters: nil, method: .GET, type: .None) { (response, error) in
            print("\(response)")
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let articleList = responseDictionary?["data"] as? [[String: Any]] {
                            var articleArray = [AAArticleModel]()
                            for eachArticle in articleList {
                                articleArray.append(AAArticleModel(eachArticle))
                                
                            }
                            //print ("asdfasdf")
                            //print (articleArray[1].articleId)
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
