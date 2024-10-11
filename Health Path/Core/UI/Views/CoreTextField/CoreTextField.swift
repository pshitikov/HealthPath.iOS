
import SwiftUI

struct BakeryTextFieldStyle: TextFieldStyle {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let height: CGFloat = 50
        
        static let promptYOffset: CGFloat = -25
        static let promptScaleEffect: CGFloat = 0.8
        
        static let strokeCornerRadius: CGFloat = 8
        static let strokeWidth: CGFloat = 0.3
        
        static let horizontalPadding: CGFloat = 16
        static let topPadding: CGFloat = 15
    }
    
    // MARK: - Properties
    
    let text: Binding<String>
    let prompt: LocalizedStringKey
    
    // MARK: - Body
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack(alignment: .leading) {
            Text(prompt)
                .foregroundColor(Color(.placeholderText))
                .offset(y: text.wrappedValue.isEmpty ? 0 : Values.promptYOffset)
                .scaleEffect(
                    text.wrappedValue.isEmpty ? 1 : Values.promptScaleEffect,
                    anchor: .leading
                )
            
            configuration
                .labelsHidden()
        }
        .padding(.top, text.wrappedValue.isEmpty ? 0 : Values.topPadding)
        .frame(height: Values.height)
        .padding(.horizontal, Values.horizontalPadding)
        .overlay(
            RoundedRectangle(cornerRadius: Values.strokeCornerRadius)
                .stroke(lineWidth: Values.strokeWidth)
                .foregroundStyle(Color.secondaryLabel)
        )
        .animation(.default, value: UUID())
    }
}
