
import Foundation

extension Decimal {
    
    var doubleValue: Double { NSDecimalNumber(decimal: self).doubleValue }
    
    var moneyValue: String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = "RUB"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: doubleValue as NSNumber) ?? ""
    }
}
