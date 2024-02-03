//
//String.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 10/01/2024.
//

import Foundation

extension String {
    
    
    
    var removingHTMLOccurancrs: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
    
    
}
