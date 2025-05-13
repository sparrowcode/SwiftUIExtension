#if os(iOS) || os(tvOS)
import SwiftUI
import SwiftBoost

internal struct LayoutGuidesObserverView: UIViewRepresentable {
    
    var layoutMarginsDidChanged: ((EdgeInsets) -> Void)? = nil
    var readableMarginsDidChanged: ((EdgeInsets) -> Void)? = nil
    
    init(
        layoutMarginsDidChanged: ((EdgeInsets) -> Void)? = nil,
        readableMarginsDidChanged: ((EdgeInsets) -> Void)? = nil
    ) {
        self.layoutMarginsDidChanged = layoutMarginsDidChanged
        self.readableMarginsDidChanged = readableMarginsDidChanged
    }
    
    func makeUIView(context: Context) -> LayoutGuidesView {
        let uiView = LayoutGuidesView()
        uiView.layoutMarginsDidChanged = layoutMarginsDidChanged
        uiView.readableMarginsDidChanged = readableMarginsDidChanged
        return uiView
    }
    
    func updateUIView(_ uiView: LayoutGuidesView, context: Context) {
        uiView.layoutMarginsDidChanged = layoutMarginsDidChanged
        uiView.readableMarginsDidChanged = readableMarginsDidChanged
    }
    
    final class LayoutGuidesView: UIView {
        
        var layoutMarginsDidChanged: ((EdgeInsets) -> Void)? = nil
        var readableMarginsDidChanged: ((EdgeInsets) -> Void)? = nil
        
        var cachedLayoutMargins: EdgeInsets? = EdgeInsets()
        var cachedReadableMargins: EdgeInsets? = EdgeInsets()
        
        override func layoutMarginsDidChange() {
            super.layoutMarginsDidChange()
            update()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            update()
        }
        
        private func update() {
            guard let viewController = self.viewController else { return }
            let safeAreaInsets = viewController.view.safeAreaInsets.edgeInsets
            
            let layout = viewController.view.layoutMargins.edgeInsets
            let correctedLayout = layout - safeAreaInsets
            
            if cachedLayoutMargins != correctedLayout {
                cachedLayoutMargins = correctedLayout
                layoutMarginsDidChanged?(correctedLayout)
            }
            
            let readable = viewController.view.readableMargins.edgeInsets
            let correctedReadable = readable - safeAreaInsets
            if cachedReadableMargins != correctedReadable {
                cachedReadableMargins = correctedReadable
                readableMarginsDidChanged?(correctedReadable)
            }
        }
    }
}

extension UIEdgeInsets {
    
    var edgeInsets: EdgeInsets {
        .init(top: self.top, leading: self.left, bottom: self.bottom, trailing: self.right)
    }
}
#endif
