//
//  AANetworkManager.swift
//  AhmedArticles
//
//  Created by Sreekanth R on 31/10/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit

public enum HTTPRestMethods: String {
    case GET        = "GET"
    case POST       = "POST"
    case DELETE     = "DELETE"
    case PUT        = "PUT"
}

public enum HTTPHeaderFieldValues: String {
    case ApplicationJSON            = "application/json; charset=utf-8"
    case ApplicationXML             = "application/xml; charset=utf-8"
    case ApplicationXHTML           = "application/xhtml+xml"
    case ApplicationUrlencoded      = "application/x-www-form-urlencoded; charset=utf-8"
    case TextXml                    = "text/xml; charset=utf-8"
    case TextPlain                  = "text/plain"
    case None                       = ""
}

class AANetworkManager: NSObject {
    
    // MARK:- REST Service
    // Calling remote service for server response.
    class func request(url:String?,parameters:Data?,method:HTTPRestMethods,type:HTTPHeaderFieldValues,completion:((String, NSError?)->())?) {
        
        self.showNetworkActivityIndicator()
        guard let serviceuUrl = URL(string: url!) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: serviceuUrl)
        
        switch type {
        case .ApplicationJSON:
            urlRequest.addValue(HTTPHeaderFieldValues.ApplicationJSON.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(HTTPHeaderFieldValues.ApplicationJSON.rawValue, forHTTPHeaderField: "Accept")
        case .ApplicationXML:
            urlRequest.addValue(HTTPHeaderFieldValues.ApplicationXML.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(HTTPHeaderFieldValues.ApplicationXML.rawValue, forHTTPHeaderField: "Accept")
        case .ApplicationUrlencoded:
            urlRequest.addValue(HTTPHeaderFieldValues.ApplicationUrlencoded.rawValue, forHTTPHeaderField: "Content-Type")
        case .TextXml:
            urlRequest.addValue(HTTPHeaderFieldValues.TextXml.rawValue, forHTTPHeaderField: "Content-Type")
        case .TextPlain:
            urlRequest.addValue(HTTPHeaderFieldValues.TextPlain.rawValue, forHTTPHeaderField: "Content-Type")
        default:
            break
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30
        urlRequest.httpBody = parameters
        
        // set up the session
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            self.hideNetworkActivityIndicator()
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        let responseString = String(data: responseData, encoding: .utf8)
                        //print("responseString : \(responseString!)")
                        
                        // For DELETE method
                        if method == HTTPRestMethods.DELETE{
                            guard let _ = data else {
                                print("error calling DELETE")
                                return
                            }
                            print("DELETE ok")
                        }
                        completion!(responseString!,nil)
                    }else {
                        print("Error: \(String(describing: error?.localizedDescription))")
                    }
                }
            }
        })
        dataTask?.resume()
    }
    
    // show the network activity indicator during the service call
    class func showNetworkActivityIndicator()  {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    // hide the network activity indicator
    class func hideNetworkActivityIndicator()  {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
