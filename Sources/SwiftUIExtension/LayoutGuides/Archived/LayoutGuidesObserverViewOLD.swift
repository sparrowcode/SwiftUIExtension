/*#if os(iOS) || os(tvOS)
import UIKit
import SwiftUI

struct LayoutGuidesObserverView: UIViewRepresentable {
    
    let onLayoutMarginsGuideChange: (EdgeInsets) -> Void
    let onReadableContentGuideChange: (EdgeInsets) -> Void
    
    func makeUIView(context: Context) -> LayoutGuidesView {
        let uiView = LayoutGuidesView()
        uiView.onLayoutMarginsGuideChange = onLayoutMarginsGuideChange
        uiView.onReadableContentGuideChange = onReadableContentGuideChange
        return uiView
    }
    
    func updateUIView(_ uiView: LayoutGuidesView, context: Context) {
        uiView.onLayoutMarginsGuideChange = onLayoutMarginsGuideChange
        uiView.onReadableContentGuideChange = onReadableContentGuideChange
    }
    
    final class LayoutGuidesView: UIView {
        var onLayoutMarginsGuideChange: (EdgeInsets) -> Void = { _ in }
        var onReadableContentGuideChange: (EdgeInsets) -> Void = { _ in }
        
        override func layoutMarginsDidChange() {
            super.layoutMarginsDidChange()
            updateLayoutMargins()
            updateReadableContent()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            updateReadableContent()
        }
        
        override var frame: CGRect {
            didSet {
                self.updateReadableContent()
            }
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.layoutDirection != previousTraitCollection?.layoutDirection {
                updateReadableContent()
            }
        }
        
        var previousLayoutMargins: EdgeInsets? = nil
        func updateLayoutMargins() {
            let edgeInsets = EdgeInsets(
                top: directionalLayoutMargins.top,
                leading: directionalLayoutMargins.leading,
                bottom: directionalLayoutMargins.bottom,
                trailing: directionalLayoutMargins.trailing
            )
            guard previousLayoutMargins != edgeInsets else { return }
            onLayoutMarginsGuideChange(edgeInsets)
            previousLayoutMargins = edgeInsets
        }
        
        var previousReadableContentGuide: EdgeInsets? = nil
        func updateReadableContent() {
            let isRightToLeft = traitCollection.layoutDirection == .rightToLeft
            let layoutFrame = readableContentGuide.layoutFrame
            
            let readableContentInsets =
            UIEdgeInsets(
                top: layoutFrame.minY - bounds.minY,
                left: layoutFrame.minX - bounds.minX,
                bottom: -(layoutFrame.maxY - bounds.maxY),
                right: -(layoutFrame.maxX - bounds.maxX)
            )
            let edgeInsets = EdgeInsets(
                top: readableContentInsets.top,
                leading: isRightToLeft ? readableContentInsets.right : readableContentInsets.left,
                bottom: readableContentInsets.bottom,
                trailing: isRightToLeft ? readableContentInsets.left : readableContentInsets.right
            )
            guard previousReadableContentGuide != edgeInsets else { return }
            onReadableContentGuideChange(edgeInsets)
            previousReadableContentGuide = edgeInsets
        }
    }
}
#endif
*/
