
import SwiftUI

struct CoreProgressView: View {
    
    // MARK: - Properties
    
    private let insertionDelay: TimeInterval
    
    // MARK: - Initialization
    
    init(insertionDelay: TimeInterval = CoreConstants.progressViewInsertionDelay) {
        self.insertionDelay = insertionDelay
    }
    
    // MARK: - Body
    
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .withOpacityAnimation(insertionDelay: insertionDelay)
    }
}

// MARK: - Previews

#Preview {
    CoreProgressView()
}
