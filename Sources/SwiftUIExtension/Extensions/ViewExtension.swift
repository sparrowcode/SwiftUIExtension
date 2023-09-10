import SwiftUI

extension View {
    
    public func onReceive(notification name: Notification.Name, perform action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: name), perform: action)
    }
    
    public func containerBackgroundForWidget<Background>(@ViewBuilder background: @escaping () -> Background) -> some View where Background: View {
        modifier(ContainerBackgroundForWidgetModifier(background: background))
    }
}

struct ContainerBackgroundForWidgetModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, watchOS 10.0, watchOSApplicationExtension 10.0, macOS 14.0, *) {
            content
                .containerBackground(for: .widget) {
                    background()
                }
        } else {
            ZStack {
                background()
                content
                    .padding()
            }
        }
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
