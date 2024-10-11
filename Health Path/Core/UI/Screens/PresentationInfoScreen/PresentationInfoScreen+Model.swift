
import SwiftUI

extension PresentationInfoScreen {
    
    @Observable
    final class Model {
        
        // MARK: - Properties
        
        let title: LocalizedStringKey
        let description: LocalizedStringKey
        let buttonTitle: LocalizedStringKey?
        let didSelect: (() -> Void)?
        
        var screenHeight: CGFloat = 0
        
        // MARK: - Initialization
        
        init(
            title: LocalizedStringKey,
            description: LocalizedStringKey,
            buttonTitle: LocalizedStringKey? = nil,
            didSelect: (() -> Void)? = nil
        ) {
            self.title = title
            self.description = description
            self.buttonTitle = buttonTitle
            self.didSelect = didSelect
        }
    }
}
