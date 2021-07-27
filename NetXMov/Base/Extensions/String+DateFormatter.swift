//
//  String+DateFormatter.swift
//  NetXMov
//
//

import Foundation

extension String {
    
    func formatDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd.MM.yy"
        
        if let date = formatter.date(from: self) {
            return newFormatter.string(from: date)
        }
        
        return "-"
    }
    
}
