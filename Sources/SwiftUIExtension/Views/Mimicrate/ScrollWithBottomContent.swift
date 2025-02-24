#if os(iOS) || os(tvOS)
import SwiftUI

public struct ScrollWithBottomContent<Content: View, Bottom: View>: View {
    
    private var content: () -> Content
    private var bottom: () -> Bottom
    
    private let topFade: CGFloat?
    private let bottomFade: CGFloat?
    
    public init(
        topFade: CGFloat? = nil,
        bottomFade: CGFloat? = Spaces.default_double,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder bottom: @escaping () -> Bottom
    ) {
        self.topFade = topFade
        self.bottomFade = bottomFade
        
        self.content = content
        self.bottom = bottom
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            content()
                .frame(maxWidth: .infinity)
                .padding(.top, topFade ?? .zero)
                .padding(.bottom, bottomFade ?? .zero)
        }
        .fitGuide(.layoutMargings, padding: .scroll)
        .fade(top: topFade, bottom: bottomFade)
        .safeAreaInset(edge: .bottom) {
            bottom()
                .padding(.bottom, Spaces.default_more)
                .fitGuide(.layoutMargings)
        }
    }
}
#endif
