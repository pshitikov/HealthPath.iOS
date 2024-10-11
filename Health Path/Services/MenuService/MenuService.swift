
import SwiftUI

@Observable
final class MenuService: MenuServiceProtocol {
    
    // MARK: - Properties
    
    var feedPath = NavigationPath()
    var diaryPath = NavigationPath()
    var searchPath = NavigationPath()
    
    var tabBarSelection: Menu = .feed
    
    // MARK: - Internal functions
    
    func didSelect(menu: Menu) { tabBarSelection = menu }
    
    func popToRoot(menu: Menu) {
        switch menu {
        case .feed: feedPath.popToRoot()
        case .diary: diaryPath.popToRoot()
        case .search: searchPath.popToRoot()
        }
    }
    
    func popCurrent() { pop(menu: tabBarSelection) }
    
    func pop(menu: Menu) {
        switch menu {
        case .feed: feedPath.removeLast()
        case .diary: diaryPath.removeLast()
        case .search: searchPath.removeLast()
        }
    }
}
