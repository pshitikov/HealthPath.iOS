
import SwiftUI

protocol MenuServiceProtocol {
    
    // MARK: - Properties
    
    var feedPath: NavigationPath { get set }
    var diaryPath: NavigationPath { get set }
    var searchPath: NavigationPath { get set }
    
    var tabBarSelection: MenuService.Menu { get set }
    
    // MARK: - Functions
    
    func didSelect(menu: MenuService.Menu)
    func popToRoot(menu: MenuService.Menu)
    func pop(menu: MenuService.Menu)
    func popCurrent()
}
