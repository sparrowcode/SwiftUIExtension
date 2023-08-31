import SwiftUI

public struct BlurFadeView: View {
    
    let style: any ShapeStyle
    let height: Double
    let startPoint: UnitPoint
    
    public init(style: any ShapeStyle, height: Double, startPoint: UnitPoint) {
        guard startPoint == .top || startPoint == .bottom else { fatalError() }
        self.style = style
        self.height = height
        self.startPoint = startPoint
    }
    
    public var body: some View {
        if #available(iOS 15.0, iOSApplicationExtension 15.0, *) {
            Rectangle()
                .fill(AnyShapeStyle(style))
                .frame(height: height)
                .mask {
                    LinearGradient(
                        colors: [.clear, .black, .black],
                        startPoint: startPoint,
                        endPoint: startPoint == .top ? .bottom : .top
                    )
                }
        }
    }
}
