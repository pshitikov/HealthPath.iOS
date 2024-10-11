
import SwiftUI

struct CoreParallaxHeaderView<Content: View, Space: Hashable>: View {
    
    // MARK: - Properties
    
    let content: () -> Content
    let coordinateSpace: Space
    let defaultHeight: CGFloat
    
    // MARK: - Initialization
    
    init(
        coordinateSpace: Space,
        defaultHeight: CGFloat,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace
        self.defaultHeight = defaultHeight
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            content()
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height + heightModifier(for: proxy)
                )
                .offset(y: offset(for: proxy))
                .edgesIgnoringSafeArea(.horizontal)
        }
        .frame(height: defaultHeight)
    }
    
    // MARK: - Private functions
    
    private func offset(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
        
        if frame.minY < 0 {
            return -frame.minY * 0.8
        }
        
        return -frame.minY
    }
    
    private func heightModifier(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
        
        return max(0, frame.minY)
    }
}
