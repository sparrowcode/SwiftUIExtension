import SwiftUI

#warning("todo to del")
/*extension View {
    
    public func horizontalSystemPadding(to view: HorizontalSystemPadding.PaddingView) -> some View {
        
        modifier(HorizontalSystemPadding(paddingView: view))
    }
    
    /*public func readableMargins() -> some View {
        self
            .padding(.horizontal)
            .frame(maxWidth: 414)
    }*/
}

public struct HorizontalSystemPadding: ViewModifier {
    
    let paddingView: PaddingView
    
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
        /*switch paddingView {
        case .scroll:
            if #available(iOS 17.0, macOS 14.0, watchOS 10.0, *) {
                content
                    .contentMargins(.horizontal, value, for: .scrollContent)
            } else {
                content
            }
        case .view:
            content.padding(.horizontal, value)
        }*/
        content
    }
    
    public enum PaddingView {
        
        case scroll
        case view
    }
}
*/
