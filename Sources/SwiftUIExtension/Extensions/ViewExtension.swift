import SwiftUI

extension View {
    

    
}



// MARK: - Only iOS



extension View {
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous) -> some View where S : ShapeStyle {
        
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius, style: style)
        
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
