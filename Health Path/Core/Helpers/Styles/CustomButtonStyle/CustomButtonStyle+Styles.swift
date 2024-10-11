
import SwiftUI

public extension CoreButtonStyle {
    
    // MARK: - Static properties
    
    static let black = Self(backgroundColor: Color.label, titleColor: Color.systemBackground)
    
    static let primary = Self(backgroundColor: Color.accentColor, titleColor: Color.white)
    
    static let selectedButtonList = Self(
        backgroundColor: Color.secondarySystemGroupedBackground,
        titleColor: Color.label,
        shadowColor: Color.label,
        shadowOpacity: 0.1
    )
    
    static let deselectedButtonList = Self(
        backgroundColor: Color.clear,
        titleColor: Color.systemGray
    )
}
