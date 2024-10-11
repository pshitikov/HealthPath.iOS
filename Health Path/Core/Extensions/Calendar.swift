
import UIKit

public extension Calendar {
    
    static var gregorian: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.locale = Locale.current
        
        return calendar
    }
    
    var shortRestDays: [String] {
        let symbols = shortWeekdaySymbols
        
        return [symbols.last, symbols.first].compactMap { $0 }
    }
    
    enum Period: Equatable {
        
        case single(Date)
        case range(Date, Date)
        
        public init?(string: String?) {
            guard let string else { return nil }
            
            let components = string.components(separatedBy: "-")
            
            if components.count == 1,
               let date = Date(string: components[0], format: .ddMMyyyy) {
                self = .single(date)
            } else if components.count == 2,
                      let start = Date(string: components[0], format: .ddMMyyyy),
                      let end = Date(string: components[1], format: .ddMMyyyy) {
                self = .range(start, end)
            } else {
                return nil
            }
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.range(let lhsStart, let lhsEnd), .range(let rhsStart, let rhsEnd)):
                lhsStart.startOfTheDay == rhsStart.startOfTheDay && lhsEnd.startOfTheDay == rhsEnd.startOfTheDay
            case (.single(let lhs), .single(let rhs)):
                lhs.startOfTheDay == rhs.startOfTheDay
            case (_, _):
                false
            }
        }
        
        public var readableString: String {
            switch self {
            case .range(let start, let end) where start == end:
                return start.string(as: .ddMMMMyyyy)
            case .range(let start, let end):
                guard start.year == end.year,
                      start.isThisYear else {
                    return "\(start.string(as: .ddMMyyyy)) - \(end.string(as: .ddMMyyyy))"
                }
                
                return "\(start.string(as: .ddMMMM)) - \(end.string(as: .ddMMMM))"
            case .single(let date):
                return date.string(as: .ddMMMMyyyy)
            }
        }
        
        public var start: Date {
            switch self {
            case .range(let start, _): start
            case .single(let date): date
            }
        }
        
        public var end: Date {
            switch self {
            case .range(_, let end): end
            case .single(let date): date
            }
        }
    }
}
