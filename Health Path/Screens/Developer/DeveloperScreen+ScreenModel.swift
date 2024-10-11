
import SwiftUI

extension DeveloperScreen {
    
    @Observable
    final class ScreenModel: StateMachine<ScreenState, ScreenEvent> {
        
        // MARK: - Properties
        
        private var serversState: ScreenState { .servers(Server.allCases) }
        
        // MARK: - Initialization
        
        init() { super.init(.initial) }
        
        // MARK: - Override functions
        
        override func handleEvent(_ event: Event) -> ScreenState? {
            switch event {
            case .onAppearScreen: serversState
            case .didSelectServer(let server): didSelectServer(server)
            }
        }
        
        // MARK: - Private functions
        
        private func didSelectServer(_ server: Server) -> ScreenState {
            UserDefaults.standard.set(
                server.url.absoluteString,
                forKey: UserDefaults.Keys.server.rawValue
            )
            
            return serversState
        }
    }
}
