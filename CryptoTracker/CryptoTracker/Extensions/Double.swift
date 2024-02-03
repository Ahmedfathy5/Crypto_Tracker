//
//  Double.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 21/12/2023.
//

import Foundation


extension Double {
    
    
    
    /// Converts a Double into a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let Formatter = NumberFormatter()
        Formatter.usesGroupingSeparator = true
        Formatter.numberStyle = .currency
//        Formatter.locale = .current // default value
//        Formatter.currencyCode = "usd" // change the currency
//        Formatter.currencySymbol = "$" // change the currency sympol
        Formatter.minimumFractionDigits = 2
        Formatter.maximumFractionDigits = 2
        return Formatter
    }
    
    
    /// Converts a Double into a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }

    
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let Formatter = NumberFormatter()
        Formatter.usesGroupingSeparator = true
        Formatter.numberStyle = .currency
//        Formatter.locale = .current // default value
//        Formatter.currencyCode = "usd" // change the currency
//        Formatter.currencySymbol = "$" // change the currency sympol
        Formatter.minimumFractionDigits = 2
        Formatter.maximumFractionDigits = 6
        return Formatter
    }
    
    
    /// Converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1.23456 to "$1.23"
    /// ```
    func asNumberString () -> String{
        return String(format: "%.2f", self)
    }
    
    
    /// Converts a Double into a String representation with precent sympol
    /// ```
    /// Convert 1.23456 to "$1.23%"
    /// ```
    func asPrecentString () -> String {
        
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
    
}
