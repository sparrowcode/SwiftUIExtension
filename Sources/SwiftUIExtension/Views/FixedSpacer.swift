import SwiftUI

public struct FixedSpacer: View {
    
    let height: CGFloat?
    let width: CGFloat?
    
    public init(height: CGFloat) {
        self.height = height
        self.width = nil
    }
    
    public init(width: CGFloat) {
        self.width = width
        self.height = nil
    }
    
    public var body: some View {
        Spacer()
            .if(height != nil, transform: { view in
                view.frame(height: height)
            })
            .if(width != nil, transform: { view in
                view.frame(width: width)
            })
        
    }
}
