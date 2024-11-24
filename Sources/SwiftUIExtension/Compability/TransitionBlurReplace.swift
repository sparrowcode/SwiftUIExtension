import SwiftUI

extension View {
    
    public func transitionBlurReplaceCombability() -> some View {
        modifier(TransitionBlurReplace())
    }
}

struct TransitionBlurReplace: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 18.0, *) {
            content
                .transition(.blurReplace.combined(with: .opacity))
        } else {
            content
                .transition(.opacity)
        }
    }
}
