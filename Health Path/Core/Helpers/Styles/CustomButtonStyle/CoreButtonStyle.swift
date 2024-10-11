
import SwiftUI

public struct CoreButtonStyle: ButtonStyle {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let maxWidth: CGFloat = 380
        
        static let horizontalPadding: CGFloat = 6
        
        static let pressedOpacity: CGFloat = 0.5
        static let disabledOpacity: CGFloat = 0.5
        static let shadowOpacity: CGFloat = 0.3
        
        static let shadowRadius: CGFloat = 10
        static let cornerRadius: CGFloat = 15
        
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - Properties
    
    private let backgroundColor: Color
    private let cornerRadius: CGFloat
    private let shadowColor: Color?
    private let shadowOpacity: CGFloat
    private let buttonHeight: CGFloat
    private let titleColor: Color
    private let isLoading: Bool
    private let disabled: Bool
    
    // MARK: - Initialization
    
    init(
        backgroundColor: Color,
        titleColor: Color,
        shadowColor: Color? = nil,
        shadowOpacity: CGFloat = Values.shadowOpacity,
        cornerRadius: CGFloat = Values.cornerRadius,
        buttonHeight: CGFloat = Values.buttonHeight,
        isLoading: Bool = false,
        disabled: Bool = false
    ) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.cornerRadius = cornerRadius
        self.buttonHeight = buttonHeight
        self.isLoading = isLoading
        self.disabled = disabled
    }
    
    // MARK: - Button Style Protocol Functions
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: buttonHeight)
            .frame(maxWidth: Values.maxWidth)
            .padding(.horizontal, Values.horizontalPadding)
            .background(backgroundColor)
            .foregroundColor(titleColor)
            .cornerRadius(cornerRadius)
            .opacity(
                disabled
                ? Values.disabledOpacity
                : configuration.isPressed ? Values.pressedOpacity : 1
            )
            .shadow(
                color: (shadowColor ?? backgroundColor).opacity(shadowOpacity),
                radius: Values.shadowRadius
            )
            .animation(nil, value: UUID())
            .overlay {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.white)
                }
            }
    }
}
