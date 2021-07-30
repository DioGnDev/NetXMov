//
//  String+URL.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 25/07/21.
//

import Foundation

extension String {
  
  func toURL() -> URL? {
    return URL(string: self)
  }
  
}
