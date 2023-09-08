import SwiftUI

extension Text {
    
    public func fontDesignCompability(_ design: Font.Design?) -> Text {
        if #available(iOS 16.1, macOS 13.0, tvOS 16.1, watchOS 9.1, *) {
            return self.fontDesign(design)
        } else {
            return self
        }
    }
}
