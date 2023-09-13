import SwiftUI

extension View {
    
    public func onReceive(notification name: Notification.Name, perform action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: name), perform: action)
    }
}

// MARK: - Only iOS

#if os(iOS)
extension View {
    
    public func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
#endif
