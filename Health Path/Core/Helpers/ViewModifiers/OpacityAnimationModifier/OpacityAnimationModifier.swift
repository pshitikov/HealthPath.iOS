
import SwiftUI

struct OpacityAnimationModifier: ViewModifier {
    
    // MARK: - Properties
    
    private var insertionDelay: TimeInterval
    
    // MARK: - Initialization
    
    init(insertionDelay: TimeInterval) { self.insertionDelay = insertionDelay }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: .opacity.animation(.default.delay(insertionDelay)),
                    removal: .opacity
                )
            )
    }
}

// MARK: - Extension

extension View {
    
    func withOpacityAnimation(insertionDelay: TimeInterval = 0.1) -> some View {
        modifier(OpacityAnimationModifier(insertionDelay: insertionDelay))
    }
}
