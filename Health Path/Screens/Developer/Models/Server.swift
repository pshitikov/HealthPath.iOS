
import Foundation

enum Server: CaseIterable, Identifiable {
    
    // MARK: - Cases
    
    case local
    case development
    case production
    
    // MARK: - Properties
    
    var id: Self { self }

    var title: String {
        switch self {
        case .local: "Локальный"
        case .development: "Тестовый"
        case .production: "Рабочий"
        }
    }
    
    var url: URL {
        switch self {
        case .local: URL(string: "")! // swiftlint:disable:this force_unwrapping
        case .development: URL(string: "")! // swiftlint:disable:this force_unwrapping
        case .production: URL(string: "")! // swiftlint:disable:this force_unwrapping
        }
    }
    
    // MARK: - Static properties
    
    static var currentServer: Server {
        let serverKey = UserDefaults.Keys.server.rawValue
        let currentServerURLString = UserDefaults.standard.string(forKey: serverKey) ?? ""
        let currentServer = Server.allCases.first(where: { $0.url == URL(string: currentServerURLString) }) ?? .production
        
        return currentServer
    }
}
