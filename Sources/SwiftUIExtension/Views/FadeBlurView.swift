import SwiftUI

@available(iOS 15.0, iOSApplicationExtension 15.0, watchOS 8.0, *)
public struct FadeBlurView: View {
    
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
