
import SwiftUI
import SafariServices

extension UIApplication {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let versionKey = "CFBundleShortVersionString"
    }
    
    // MARK: - Static properties
    
    /// Полная версия приложения, которая включает версию и билд
    /// Пример: 1.0.0 (8)
    static var fullVersion: String { "\(shortVersion.rawValue) (\(build?.rawValue ?? ""))" }
    
    /// Короткая версия приложения, без значения билда
    /// Пример: 1.0.0
    static var shortVersion: Value {
        guard let value = Bundle.main.infoDictionary?[Values.versionKey] as? String else { return .empty }
        
        return Value(rawValue: value)
    }
    
    /// Версия билда приложения
    static var build: Value? {
        guard let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String else { return nil }
        
        return Value(rawValue: build)
    }
    
    // MARK: - Static functions
    
    /// Определение доступности версии
    /// - Parameter minVersion: минимально поддерживаемая версия
    /// - Returns: доступность версии
    static func isAvailable(minVersion: String) -> Bool {
        let minVersion = Value(rawValue: minVersion)
        let currentVersionValue = Value(rawValue: "\(shortVersion.rawValue).\(build?.rawValue ?? "")")
        
        return minVersion <= currentVersionValue
    }
    
    /// Открытие ссылки в рамках SFSafariViewController
    /// - Parameter url: ссылка для открытия
    static func presentSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow?
            .rootViewController?
            .present(safariViewController, animated: true)
    }
}

extension UIApplication {
    
    /// Структура для работы со значением версии приложения
    struct Value: RawRepresentable, Comparable {
        
        // MARK: - Static properties
        
        static let empty = Self(rawValue: "")
        
        // MARK: - Properties
        
        /// Версия приложения
        private(set) var rawValue: String
        
        // MARK: - Comparable
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            let lhsComponents = lhs.rawValue.components(separatedBy: ".").compactMap { Int($0) }
            let rhsComponents = rhs.rawValue.components(separatedBy: ".").compactMap { Int($0) }
            
            guard lhsComponents != rhsComponents else { return lhsComponents.lexicographicallyPrecedes(rhsComponents) }
            
            let length = min(lhsComponents.count, rhsComponents.count)
            let lhsCut = lhsComponents.prefix(length)
            let rhsCut = rhsComponents.prefix(length)
            
            return lhsCut.lexicographicallyPrecedes(rhsCut)
        }
    }
}

extension UIApplication {
    
    /// Свойтво для определения текущего состояния приложения
    /// DEBUG или PROD
    var isProduction: Bool {
    #if DEBUG
        return false
    #else
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return true }
        
        return !path.contains("sandboxReceipt")
    #endif
    }
}
