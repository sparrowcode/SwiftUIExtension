import SwiftUI

extension View {
    
    /**
     Default value for `safeAreaInset` none zero — this wrapper drop all spaces.
     */
    public func safeAreaInsetNoneSpaced<Content: View>(edge: VerticalEdge, @ViewBuilder content: () -> Content) -> some View {
        self
            .safeAreaInset(edge: edge, spacing: .zero) {
                content()
            }
    }
}

// MARK: - Environment

#if os(iOS)
extension EnvironmentValues {
    
    public var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.rootController?.view.window?.safeAreaInsets ?? .zero).insets
        //(UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
#endif
