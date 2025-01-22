//
//  AAStringExtensions.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 23/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
