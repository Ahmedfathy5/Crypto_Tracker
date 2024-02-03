//
//  statisticsModel.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 24/12/2023.
//

import Foundation


struct statisticsModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let precentageChange: Double?
    
    
    init(title: String ,  value: String,precentageChange: Double? = nil ) {
        self.title = title
        self.value = value
        self.precentageChange = precentageChange
    }
    
    
}
 
