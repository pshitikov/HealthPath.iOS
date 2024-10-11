
import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let scale: CGFloat = 0.95
        static let animationDuration = 0.25
    }
    
    // MARK: - Public functions
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? Values.scale : 1)
            .animation(.easeInOut(duration: Values.animationDuration), value: UUID())
    }
}
