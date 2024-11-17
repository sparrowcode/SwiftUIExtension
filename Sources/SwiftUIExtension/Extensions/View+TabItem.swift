import SwiftUI

extension View {
    
    public func disableSwipeForTabItem() -> some View {
        self.gesture(DragGesture())
    }
}
