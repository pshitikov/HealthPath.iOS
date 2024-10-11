
import SwiftUI
import SDWebImageSwiftUI

struct CoreErrorView: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let retryButtonTitle = "Повторить"
        
        static let verticalStackSpacing: CGFloat = 20
    }
    
    // MARK: - Properties
    
    private let error: CoreErrorViewProtocol
    private let retryAction: (() -> Void)?
    
    // MARK: - Initialization
    
    init(error: CoreErrorViewProtocol, retryAction: (() -> Void)? = nil) {
        self.error = error
        self.retryAction = retryAction
    }
    
    // MARK: - Body
    
    var body: some View {
        ContentUnavailableView(
            label: { label },
            description: { description },
            actions: { actions }
        )
    }
    
    // MARK: - Views
    
    private var label: some View {
        Label(
            title: { Text(error.title ?? "") },
            icon: { image }
        )
    }
    
    @ViewBuilder
    private var description: some View {
        if let description = error.description {
            Text(description)
        }
    }
    
    @ViewBuilder
    private var actions: some View {
        if error.withRetryButton {
            Button(Values.retryButtonTitle) { retryAction?() }
                .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder
    private var image: some View {
        if let imageLink = error.imageLink {
            WebImage(url: URL(string: imageLink))
        } else if let imageResource = error.imageResource {
            Image(imageResource)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Previews

#Preview {
    CoreErrorView(error: AppError.unknown)
}
