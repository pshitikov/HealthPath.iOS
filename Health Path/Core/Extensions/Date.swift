
import Foundation

internal extension Date {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    struct DateFormat: RawRepresentable {
        
        internal private(set) var rawValue: String
        internal private(set) var additionalString = ""
        internal private(set) var decodingTimeZone: TimeZone?
        internal private(set) var encodingTimeZone: TimeZone?
        
        internal init(rawValue pRawValue: String) {
            rawValue = pRawValue
        }
        
        internal init(
            rawValue pRawValue: String,
            additionalString pAdditionalString: String = "",
            decodingTimeZone pDecodingTimeZone: TimeZone? = nil,
            encodingTimeZone pEncodingTimeZone: TimeZone? = nil
        ) {
            rawValue = pRawValue
            additionalString = pAdditionalString
            decodingTimeZone = pDecodingTimeZone
            encodingTimeZone = pEncodingTimeZone
        }
        
        // LLL - март, MMM - марта
        
        internal static let HHmm = Self(rawValue: "HH:mm")
        internal static let weekday = Self(rawValue: "EEEE")
        internal static let month = Self(rawValue: "LLLL")
        internal static let monthShort = Self(rawValue: "LLL")
        internal static let monthYear = Self(rawValue: "LLLL yyyy")
        internal static let year = Self(rawValue: "yyyy")
        
        internal static let yyyyMMdd = Self(rawValue: "yyyy-MM-dd")
        internal static let ISO8601 = Self(rawValue: "yyyy-MM-dd'T'HH:mm:ssZ")
        internal static let oldISO8601 = Self(rawValue: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
        
        internal static let ddMM = Self(rawValue: "dd.MM")
        internal static let ddMMMM = Self(rawValue: "dd MMMM")
        internal static let ddMMMMEEEE = Self(rawValue: "dd MMMM, EEEE")
        internal static let ddMMyyyy = Self(rawValue: "dd.MM.yyyy")
        internal static let ddMMyyyySlash = Self(rawValue: "dd/MM/yyyy")
        internal static let ddMMyyyyHHmm = Self(rawValue: "dd.MM.yyyy HH:mm")
        internal static let ddMMyyyyTime = Self(rawValue: "dd.MM.yyyy HH:mm:ss")
        internal static let ddMMMMyyyy = Self(rawValue: "dd MMMM yyyy", additionalString: " г.")
    }
    
    init?(string: String, format: DateFormat) {
        self.init(string: string, format: format.rawValue, timezone: format.decodingTimeZone)
    }
    
    init?(string: String, format: String, timezone: TimeZone? = nil) {
        let formatter = Self.formatter
        
        Self.formatter.timeZone = timezone
        Self.formatter.dateFormat = format
        
        guard let value = formatter.date(from: string) else { return nil }
        
        self = value
    }
    
    init(year: Int, month: Int, day: Int) {
        var dateComponent = DateComponents()
        
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        
        guard let value = Calendar.gregorian.date(from: dateComponent) else {
            self = Date()
            return
        }
        
        self = value
    }
    
    func string(as format: DateFormat) -> String {
        string(as: format.rawValue, timezone: format.encodingTimeZone) + format.additionalString
    }
    
    func string(as format: String, timezone: TimeZone? = nil) -> String {
        let formatter = Self.formatter
        
        Self.formatter.timeZone = timezone
        Self.formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func isBetween(_ date1: Date, _ date2: Date) -> Bool {
        (min(date1, date2)...max(date1, date2)) ~= self
    }
    
    func adding(years: Int = 0, months: Int = 0, days: Int = 0, minutes: Int = 0) -> Date {
        var dateComponent = DateComponents()
        
        if years != 0 {
            dateComponent.year = years
        }
        
        if months != 0 {
            dateComponent.month = months
        }
        
        if days != 0 {
            dateComponent.day = days
        }
        
        if minutes != 0 {
            dateComponent.minute = minutes
        }
        
        guard let newDate = Calendar.gregorian.date(byAdding: dateComponent, to: self) else { return self }
        
        return newDate
    }
    
    func components(_ components: Set<Calendar.Component>, before end: Date) -> DateComponents {
        Calendar.gregorian.dateComponents(components, from: self, to: end)
    }
    
    var stringInHistory: String {
        if isToday {
            return "Сегодня"
        } else if isYesterday {
            return "Вчера"
        } else if isThisYear {
            return string(as: .ddMMMMEEEE)
        } else {
            return string(as: .ddMMMMyyyy)
        }
    }
    
    var isToday: Bool { Calendar.gregorian.isDateInToday(self) }
    var isYesterday: Bool { Calendar.gregorian.isDateInYesterday(self) }
    var isTomorrow: Bool { Calendar.gregorian.isDateInTomorrow(self) }
    var isThisYear: Bool { year == Date().year }
    
    var startOfTheDay: Date { Calendar.gregorian.startOfDay(for: self) }
    var startOfTheMonth: Date? { Calendar.gregorian.dateInterval(of: .month, for: self)?.start }
    
    var hour: Int { Calendar.gregorian.component(.hour, from: self) }
    var day: Int { Calendar.gregorian.component(.day, from: self) }
    var weekday: Int { Calendar.gregorian.component(.weekday, from: self) }
    var month: Int { Calendar.gregorian.component(.month, from: self) }
    var year: Int { Calendar.gregorian.component(.year, from: self) }
    var daysInMonth: Int { Calendar.gregorian.range(of: .day, in: .month, for: self)?.count ?? 0 }
    
    var calendarDaysInMonth: Int {
        var daysInMonth = daysInMonth + calendarMonthPrefix
        let daysSuffix = daysInMonth % 7
        
        if daysSuffix != 0 {
            daysInMonth += 7 - daysSuffix
        }
        
        return daysInMonth
    }
    
    var calendarMonthPrefix: Int {
        let prefix = weekday - Calendar.gregorian.firstWeekday
        
        return prefix < 0 ? 7 + prefix : prefix
    }
}
