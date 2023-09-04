import SwiftUI

#if os(iOS)
public struct AdaptiveStack<Content: View>: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        #if os(visionOS)
        Text("Unsupported")
        #else
        Group {
            if orientation.isLandscape {
                HStack {
                    content()
                }
            } else {
                VStack {
                    content()
                }
            }
        }
        .detectOrientation($orientation)
        #endif
    }
}

struct DetectOrientation: ViewModifier {
    
    @Binding var orientation: UIDeviceOrientation
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                orientation = UIDevice.current.orientation
            }
    }
}


extension View {
    
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View {
        modifier(DetectOrientation(orientation: orientation))
    }
}
#endif
