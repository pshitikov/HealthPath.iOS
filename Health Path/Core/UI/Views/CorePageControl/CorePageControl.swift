
import SwiftUI

struct CorePageControl: UIViewRepresentable {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let preferredDuration: TimeInterval = 10
    }
    
    // MARK: - Properties
    
    private var numberOfPages: Int
    
    @Binding
    private var currentPage: Int
    
    // MARK: - Initialization
    
    init(numberOfPages: Int, currentPage: Binding<Int>) {
        self.numberOfPages = numberOfPages
        _currentPage = currentPage
    }
    
    // MARK: - UIViewRepresentable
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
                
        let progress = UIPageControlTimerProgress(preferredDuration: Values.preferredDuration)
        progress.resetsToInitialPageAfterEnd = true
        progress.resumeTimer()
        
        control.progress = progress
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) { uiView.currentPage = currentPage }
}

// MARK: - Coordinator

extension CorePageControl {
    
    final class Coordinator: NSObject {
        
        // MARK: - Properties
        
        var control: CorePageControl
        
        // MARK: - Initialization
        
        init(_ control: CorePageControl) { self.control = control }
        
        // MARK: - Internal functions
        
        @objc
        func updateCurrentPage(sender: UIPageControl) { control.currentPage = sender.currentPage }
    }
}
