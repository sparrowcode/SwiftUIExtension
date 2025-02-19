import SwiftUI

extension View {
    
    public func clipShapeWithBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous) -> some View where S : ShapeStyle {
        
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius, style: style)
        
        return self
            .clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
