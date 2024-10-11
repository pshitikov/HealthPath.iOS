
import Foundation

extension FeedScreen {
    
    enum ScreenState: Equatable {
        
        // MARK: - Cases
        
        case initial
        case loading
        case data
        case error(_ error: AppError)
    }
}
