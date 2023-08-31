import SwiftUI
import WidgetKit

@available(watchOS 9.0, *)
extension WidgetConfiguration {
    
    public func contentMarginsSafeDisabled() -> some WidgetConfiguration {
        if #available(iOS 15.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}
