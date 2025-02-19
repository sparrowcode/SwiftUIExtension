import SwiftUI
import SwiftBoost

extension View {
    
    public func higlight<S>(clipShape: S) -> some View where S : Shape {
        self.modifier(HiglightModifier(clipShape: clipShape))
    }
}

struct HiglightModifier<S>: ViewModifier where S : Shape {
    
    @State private var isAnimatingHiglight = false
    @State private var isAnimatingScale = false
    
    private let clipShape: S
    
    private var higlightDuration: TimeInterval = 1
    private var calmDuration: TimeInterval = 3
    private var changeAppearanceDuration: TimeInterval = 0.26
    
    private var blinkWidth: CGFloat { 18 }
    private var scale: CGFloat = 0.94
    
    init(clipShape: S) {
        self.clipShape = clipShape
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Rectangle()
                        .blur(radius: 6)
                        .vibrant(0.7)
                        .frame(width: blinkWidth)
                        .frame(height: proxy.size.height * 2)
                        .rotationEffect(.degrees(45))
                        .position(
                            x: isAnimatingHiglight ? (proxy.size.width + proxy.size.height) : (0 - proxy.size.height),
                            y: proxy.size.height / 2
                        )
                        .clipShape(clipShape)
                        .animation(isAnimatingHiglight ? .interpolatingSpring(duration: higlightDuration) : .none, value: isAnimatingHiglight)
                }
            }
            .scaleEffect(isAnimatingScale ? scale : 1)
            .animation(.interpolatingSpring(duration: changeAppearanceDuration), value: isAnimatingScale)
            .onAppear {
                run()
            }
    }
    
    private func run() {
        
        isAnimatingHiglight = true
        isAnimatingScale = true
        
        delay(higlightDuration / 2) {
            isAnimatingScale = false
        }
        
        delay(higlightDuration) {
            isAnimatingHiglight = false
            delay(calmDuration) {
                self.run()
            }
        }
    }
}
