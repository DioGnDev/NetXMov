//
//  String+URL.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import Foundation

extension String {
    
    func toURL() -> URL? {
        return URL(string: self)
    }
    
}
