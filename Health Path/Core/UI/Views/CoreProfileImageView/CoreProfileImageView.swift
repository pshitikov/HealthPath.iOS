
import SwiftUI
import SFSafeSymbols

struct CoreProfileImageView: View {
    
    // MARK: - Properties
    
    private var imageData: Data?
    
    // MARK: - Initialization
    
    init(imageData: Data? = nil) {
        self.imageData = imageData
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let imageData,
               let userImage = Image(data: imageData) {
                userImage
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: SFSymbol.personCropCircleFill.rawValue)
                    .resizable()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.secondaryLabel, Color.systemGray3)
            }
        }
        .clipShape(.circle)
    }
}

// MARK: - Previews

#Preview {
    CoreProfileImageView()
}
