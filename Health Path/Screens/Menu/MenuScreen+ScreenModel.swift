
import SwiftUI

extension MenuScreen {
    
    @Observable
    final class ScreenModel: StateMachine<ScreenState, Event> {
        
        // MARK: - Properties
        
        private let authorizationService: AuthorizationService
        private var menuService: MenuServiceProtocol
        
        private let menu = MenuService.Menu.allCases
        
        var feedPath: NavigationPath {
            get { menuService.feedPath }
            set { menuService.feedPath = newValue }
        }
        
        var diaryPath: NavigationPath {
            get { menuService.diaryPath }
            set { menuService.diaryPath = newValue }
        }
        
        var searchPath: NavigationPath {
            get { menuService.searchPath }
            set { menuService.searchPath = newValue }
        }
        
        var tabBarSelection: MenuService.Menu {
            get { menuService.tabBarSelection }
            set { menuService.tabBarSelection = newValue }
        }
        
        // MARK: - Initialization
        
        init(
            authorizationService: AuthorizationService = ServiceLocator.authorizationService,
            menuService: MenuServiceProtocol = ServiceLocator.menuService
        ) {
            self.authorizationService = authorizationService
            self.menuService = menuService
            
            super.init(.initial)
        }
        
        // MARK: - Override functions
        
        override func handleEvent(_ event: Event) -> ScreenState? {
            switch event {
            case .onAppearScreen: return .menu(menu)
            }
        }
        
        // MARK: - Private functions
    }
}
