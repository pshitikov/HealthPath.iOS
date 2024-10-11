
import SwiftUI

extension SearchScreen {
    
    @Observable
    final class ScreenModel: StateMachine<ScreenState, ScreenEvent> {
        
        // MARK: - Properties
        
        // MARK: - Initialization
        
        init() { super.init(.initial) }
        
        // MARK: - Override functions
        
        override func handleEvent(_ event: Event) -> ScreenState? {
            switch event {
            case .onAppearScreen: return .data
            }
        }
        
        // MARK: - Private functions
    }
}
