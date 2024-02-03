//
//  UIAplication.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 23/12/2023.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
