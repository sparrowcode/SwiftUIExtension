import SwiftUI

extension View {
    
    public func horizontalSystemPadding() -> some View {
        modifier(HorizontalSystemPadding())
    }
}

struct HorizontalSystemPadding: ViewModifier {
    
    var value: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return 16
        case .regular:
            #if os(visionOS)
            return 24
            #else
            return 20
            #endif
        default:
            return 16
        }
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    public func body(content: Content) -> some View {
        if #available(iOS 17.0, macOS 14.0, watchOS 10.0, *) {
            content
                .contentMargins(.horizontal, value, for: .scrollContent)
        } else {
            content
        }
    }
}
