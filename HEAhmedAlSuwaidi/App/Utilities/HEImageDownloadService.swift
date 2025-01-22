//
//  HEImageDownloadService.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 17/12/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class HEImageDownloadService: NSObject {
    func download(_ url: URL, completion: @escaping ((UIImage?, Error?) -> ())) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data), nil)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in completion(data, response, error) }.resume()
    }
}
