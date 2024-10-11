
import SwiftUI

struct CoreProfileButtonView: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let imageSize = CGSize(width: 32, height: 32)
    }
    
    // MARK: - Properties
    
    private var imageData: Data?
    private var didSelect: (() -> Void)?
    // MARK: - Initialization
    
    init(imageData: Data? = nil, didSelect: (() -> Void)? = nil) {
        self.imageData = imageData
        self.didSelect = didSelect
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(
            action: { didSelect?() },
            label: { buttonLabelView }
        )
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var buttonLabelView: some View {
        CoreProfileImageView(imageData: imageData)
            .frame(width: Values.imageSize.width, height: Values.imageSize.height)
    }
}

// MARK: - Previews

#Preview {
    CoreProfileButtonView()
}
