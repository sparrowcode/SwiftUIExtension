import SwiftUI

extension View {
    
    public func matchedTransitionSourceCompability(id: some Hashable, in namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, macOS 14.0, visionOS 2.0, *) {
            return self.matchedTransitionSource(id: id, in: namespace)
        } else {
            return self
        }
    }
    
    public func navigationTransitionZoom(id: some Hashable, in namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, macOS 14.0, visionOS 2.0, *) {
            return self.navigationTransition(.zoom(sourceID: id, in: namespace))
        } else {
            return self
        }
    }
}
