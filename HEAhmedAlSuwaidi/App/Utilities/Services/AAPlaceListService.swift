
import UIKit

class AAPlaceListService: NSObject {
    let apiPath = "hea_json_placelist1.php"
    public func getPlaceList(_ completion: @escaping (([AAPlaceListModel]?, Error?) -> ())) {
        AANetworkManager.request(url: apiUrl + apiPath, parameters: nil, method: .GET, type: .None) { (response, error) in
            if error == nil {
                if let data = response.data(using: .utf8) {
                    do {
                        let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let placeList = responseDictionary?["place"] as? [[String: Any]] {
                            var placesArray = [AAPlaceListModel]()
                            for eachPlace in placeList {
                                placesArray.append(AAPlaceListModel(eachPlace))
                            }
                            completion(placesArray, nil)
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
