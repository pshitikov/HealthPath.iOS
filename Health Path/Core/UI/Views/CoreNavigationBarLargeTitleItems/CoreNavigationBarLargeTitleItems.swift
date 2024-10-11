
import SwiftUI

struct CoreNavigationBarLargeTitleItems<Content>: UIViewControllerRepresentable where Content: View {
    
    // MARK: - Typealiases
    
    typealias UIViewControllerType = Wrapper
    
    // MARK: - Properties
    
    @ViewBuilder
    let trailingItems: () -> Content
    
    // MARK: - Initialization
    
    init(@ViewBuilder trailing: @escaping () -> Content) { trailingItems = trailing }
    
    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: Context) -> Wrapper { Wrapper(representable: self) }
    
    func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
        uiViewController.addTrailingItems()
    }
}
