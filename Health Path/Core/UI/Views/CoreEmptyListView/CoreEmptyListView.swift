
import SwiftUI

struct CoreEmptyListView: View {
    
    // MARK: - Body
    
    var body: some View {
        List { EmptyView() }
            .scrollDisabled(true)
            .withOpacityAnimation()
    }
}

// MARK: - Previews

#Preview { CoreEmptyListView() }
