
import SwiftUI

public extension PresentationHeightModifier {
    
    struct Key: PreferenceKey {
        
        // MARK: - Properties
        
        public static var defaultValue: CGFloat = 0
        
        // MARK: - Static functions
        
        public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
    }
}
