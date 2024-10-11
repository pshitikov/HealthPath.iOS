
import SwiftUI

extension MenuService {
    
    enum Menu: String, Identifiable, CaseIterable {
        
        // MARK: - Identifiable
        
        var id: Self { self }
        
        // MARK: - Cases
        
        case feed
        case diary
        case search
        
        // MARK: - Properties
        
        var name: LocalizedStringKey {
            switch self {
            case .feed: "Лента"
            case .diary: "Дневник"
            case .search: "Поиск"
            }
        }
        
        var image: Image {
            switch self {
            case .feed: Image(systemSymbol: .listBullet)
            case .diary: Image(systemSymbol: .book)
            case .search: Image(systemSymbol: .magnifyingglass)
            }
        }
    }
}
