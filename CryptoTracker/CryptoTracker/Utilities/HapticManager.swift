//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 02/01/2024.
//

import Foundation
import SwiftUI


class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    
    static func Notification(type: UINotificationFeedbackGenerator.FeedbackType) {

        generator.notificationOccurred(type)
        
        
    }
    
    
}
