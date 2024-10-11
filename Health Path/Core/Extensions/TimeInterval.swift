
import Foundation

extension TimeInterval {
    
    func format(using units: NSCalendar.Unit) -> String? {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        return formatter.string(from: self)
    }
}
