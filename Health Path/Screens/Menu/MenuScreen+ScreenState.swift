
import Foundation

extension MenuScreen {
    
    enum ScreenState: Equatable {
        
        // MARK: - Cases
        
        case initial
        case loading
        case menu(_ menu: [MenuService.Menu])
        case error(_ error: AppError)
    }
}
