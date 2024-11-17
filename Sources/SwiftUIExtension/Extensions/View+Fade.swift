import SwiftUI

extension View {
    
    public func fade(top: CGFloat? = nil, bottom: CGFloat? = nil) -> some View {
        modifier(VerticalFade(top: top, bottom: bottom))
    }
}

struct VerticalFade: ViewModifier {
    
    let top: CGFloat?
    let bottom: CGFloat?
    
    func body(content: Content) -> some View {
        content
             .mask {
                 VStack(spacing: .zero) {
                     
                     if let top {
                         // Top Fade
                         LinearGradient(colors: [Color.black.opacity(0), Color.black], startPoint: .top, endPoint: .bottom)
                             .frame(height: top)
                     }
                     
                     // Middle
                     Rectangle()
                         .fill(Color.black)
                         .ignoresSafeArea()
                     
                     if let bottom {
                         // Bottom Fade
                         LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: .top, endPoint: .bottom)
                             .frame(height: bottom)
                     }
                 }
             }
    }
}
