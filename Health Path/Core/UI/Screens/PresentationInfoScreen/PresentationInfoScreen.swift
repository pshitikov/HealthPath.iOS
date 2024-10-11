
import SwiftUI
import SFSafeSymbols

struct PresentationInfoScreen: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let verticalSpacing: CGFloat = 8
        static let closeButtonSize: CGFloat = 30
        static let closeButtonTopPadding: CGFloat = 20
    }
    
    // MARK: - Properties
    
    @Environment(\.dismiss)
    private var dismiss
    
    @State
    private var model: Model
    
    // MARK: - Initialization
    
    init(model: Model) { _model = State(initialValue: model) }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: Values.verticalSpacing) {
            header
            description
        }
        .safeAreaInset(edge: .bottom, content: { actionButton })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .padding(.horizontal, CoreConstants.horizontalPadding)
        .modifier(PresentationHeightModifier(height: $model.screenHeight))
        .interactiveDismissDisabled(false)
        .presentationBackgroundInteraction(.disabled)
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(model.screenHeight)])
    }
}

// MARK: - Views

extension PresentationInfoScreen {
    
    private var header: some View {
        HStack {
            Text(model.title)
                .fixedSize(horizontal: false, vertical: true)
                .font(Font.title2)
                .bold()
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: SFSymbol.xmarkCircleFill.rawValue)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.tertiaryLabel, .ultraThinMaterial)
                    .font(.system(size: Values.closeButtonSize))
            })
        }
    }
    
    private var description: some View {
        Text(model.description)
            .fixedSize(horizontal: false, vertical: true)
            .font(Font.body)
            .foregroundStyle(Color.secondaryLabel)
    }
    
    @ViewBuilder
    private var actionButton: some View {
        if let buttonTitle = model.buttonTitle {
            Button(buttonTitle) {
                dismiss()
                model.didSelect?()
            }
            .buttonStyle(CoreButtonStyle.primary)
            .padding(.top, Values.closeButtonTopPadding)
        }
    }
}
// MARK: - Previews

#Preview {
    PresentationInfoScreen(
        model: PresentationInfoScreen.Model(
            title: "reusable_continue_title",
            description: "reusable_continue_title",
            buttonTitle: "reusable_delete_title"
        )
    )
}
