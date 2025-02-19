import SwiftUI

extension View {
    
    func vibrant(_ intensity: CGFloat) -> some View {
        self.modifier(VibrantModifier(intensity: intensity))
    }
}

struct VibrantModifier: ViewModifier {
    
    let intensity: CGFloat
    
    init(intensity: CGFloat) {
        self.intensity = intensity
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white.opacity(1 - intensity))
            .blendMode(.plusLighter)
    }
}
