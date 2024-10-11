
import SwiftUI

public struct PresentationHeightModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding
    var height: CGFloat
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .overlay { geometryReader }
            .onPreferenceChange(Key.self) { newHeight in height = newHeight }
    }
    
    // MARK: - Views
    
    private var geometryReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: Key.self, value: geometry.size.height)
        }
    }
}
