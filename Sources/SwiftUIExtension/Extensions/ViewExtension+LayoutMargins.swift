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
    
    //var withCompensation: Bool = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    public func body(content: Content) -> some View {
        /*let compensation: CGFloat = {
            #if os(visionOS)
            return -14
            #else
            return .zero
            #endif
        }()*/
        if #available(iOS 17.0, macOS 14.0, *) {
            content
                .contentMargins(.horizontal, value, for: .scrollContent)
        } else {
            content
        }
    }
}
