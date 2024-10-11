
import SwiftUI

public extension View {
    
    @ViewBuilder
    func customHeaderView<Content: View>(@ViewBuilder _ headerView: @escaping () -> Content, height: CGFloat) -> some View {
        overlay(content: {
            CoreNavigationHeaderView(headerView: headerView, height: height)
                .frame(width: 0, height: 0)
        })
    }
}

public struct CoreNavigationHeaderView<HeaderView: View>: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    @ViewBuilder
    public var headerView: () -> HeaderView
    
    let height: CGFloat
    
    // MARK: - UIViewControllerRepresentable
    
    public func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerWrapper(
            headerView: headerView,
            height: height
        )
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {} // swiftlint:disable:this no_empty_block
}

extension CoreNavigationHeaderView {
    
    class ViewControllerWrapper: UIViewController {
        
        // MARK: - Properties
        
        let headerView: () -> HeaderView
        let height: CGFloat
        
        // MARK: - Initialization
        
        init(headerView: @escaping () -> HeaderView, height: CGFloat) {
            self.headerView = headerView
            self.height = height
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Life cycle
        
        override func viewWillAppear(_ animated: Bool) {
            guard let navigationController = self.navigationController, let navigationItem = navigationController.visibleViewController?.navigationItem else { return }
            
            let navBarPallete = NSClassFromString("_UINavigationBarPalette") as? UIView.Type
            
            let castedHeaderView = UIHostingController(rootView: self.headerView()).view
            castedHeaderView?.frame.size.height = height
            castedHeaderView?.backgroundColor = .clear
            
            let palette = navBarPallete?.perform(NSSelectorFromString("alloc"))
                .takeUnretainedValue()
                .perform(NSSelectorFromString("initWithContentView:"), with: castedHeaderView)
                .takeUnretainedValue()
            
            navigationItem.perform(NSSelectorFromString("_setBottomPalette:"), with: palette)
            
            super.viewWillAppear(animated)
        }
    }
}
