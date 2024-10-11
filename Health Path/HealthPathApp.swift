
import SwiftUI

@main
struct HealthPathApp: App {
    
    // MARK: - Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var delegate
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MenuScreen(screenModel: .init())
        }
    }
}
