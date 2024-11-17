import SwiftUI

public struct SizeTracker: ViewModifier {
    
    @Binding var size: CGSize
    
    public func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        self.size = geometry.size
                    }
                    .onChange(of: geometry.size) { newSize in
                        self.size = newSize
                    }
            }
        )
    }
}

extension View {
    
    public func sizeChanged(_ size: Binding<CGSize>) -> some View {
        self.modifier(SizeTracker(size: size))
    }
}
