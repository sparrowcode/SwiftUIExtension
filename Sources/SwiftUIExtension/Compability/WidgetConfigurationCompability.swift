import SwiftUI
import WidgetKit

@available(watchOS 9.0, macOS 11.0, *)
extension WidgetConfiguration {
    
    public func contentMarginsSafeDisabled() -> some WidgetConfiguration {
        if #available(iOS 15.0, macOS 12.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}
