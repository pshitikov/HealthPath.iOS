
enum ServiceLocator {

    // MARK: - Private properties

    private static var _authorizationService = AuthorizationService()
    private static var _menuService = MenuService()
    
    // MARK: - Internal properties

    static var authorizationService: AuthorizationService { _authorizationService }
    static var menuService: MenuService { _menuService }
}
