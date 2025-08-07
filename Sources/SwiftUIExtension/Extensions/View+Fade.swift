import SwiftUI

extension View {
    
    public func fade(
        top: CGFloat? = nil,
        bottom: CGFloat? = nil,
        leading: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) -> some View {
        modifier(
            Fade(
                top: top,
                bottom: bottom,
                leading: leading,
                trailing: trailing
            )
        )
    }
    
    public func fade(
        horizontal: CGFloat? = nil,
        vertical: CGFloat? = nil
    ) -> some View {
        modifier(
            Fade(
                top: vertical,
                bottom: vertical,
                leading: horizontal,
                trailing: horizontal
            )
        )
    }
}

struct Fade: ViewModifier {
    
    let top: CGFloat?
    let bottom: CGFloat?
    let leading: CGFloat?
    let trailing: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .mask {
                VStack(spacing: .zero) {
                    
                    // Top Fade
                    if let top {
                        LinearGradient(colors: [Color.black.opacity(0), Color.black], startPoint: .top, endPoint: .bottom)
                            .frame(height: top)
                    }
                    
                    // Middle
                    Rectangle()
                        .fill(Color.black)
                        .ignoresSafeArea()
                    
                    // Bottom Fade
                    if let bottom {
                        LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: .top, endPoint: .bottom)
                            .frame(height: bottom)
                    }
                }
                .mask {
                    HStack(spacing: .zero) {
                        
                        // Top Fade
                        if let leading {
                            LinearGradient(colors: [Color.black.opacity(0), Color.black], startPoint: .leading, endPoint: .trailing)
                                .frame(width: leading)
                        }
                        
                        // Middle
                        Rectangle()
                            .fill(Color.black)
                            .ignoresSafeArea()
                        
                        // Bottom Fade
                        if let trailing {
                            LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: .leading, endPoint: .trailing)
                                .frame(width: trailing)
                        }
                    }
                }
             }
    }
}
