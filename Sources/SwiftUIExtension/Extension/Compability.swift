import SwiftUI
import WidgetKit

extension View {
    
    public func fontWeightCompability(_ weight: Font.Weight) -> some View {
        if #available(iOS 16.0, *) {
            return self.fontWeight(weight)
        } else {
            return self
        }
    }
    
    public func invalidatableContentCompability() -> some View {
        if #available(iOS 17.0, *) {
            return self.invalidatableContent()
        } else {
            return self
        }
    }
}
