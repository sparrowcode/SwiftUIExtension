import SwiftUI
import WidgetKit

extension WidgetConfiguration {
    
    public func contentMarginsSafeDisabled() -> some WidgetConfiguration {
        if #available(iOS 15.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}
