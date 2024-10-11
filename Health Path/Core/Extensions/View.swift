
import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}

extension View {
    
    func roundedCornerWithBorder(
        lineWidth: CGFloat = 0.7,
        borderColor: Color = Color.systemGray5,
        radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
            .overlay(
                RoundedCorner(radius: radius, corners: corners)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}
