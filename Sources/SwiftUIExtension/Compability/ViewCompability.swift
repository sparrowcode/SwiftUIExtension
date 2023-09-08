import SwiftUI

extension View {
    
    public func fontWeightCompability(_ weight: Font.Weight) -> some View {
        if #available(iOS 16.0, watchOS 9.0, macOS 13.0, *) {
            return self.fontWeight(weight)
        } else {
            return self
        }
    }
    
    public func invalidatableContentCompability() -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            return self.invalidatableContent()
        } else {
            return self
        }
    }
    
    public func scrollTargetLayoutCompability(isEnabled: Bool = true) -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            return self.scrollTargetLayout(isEnabled: isEnabled)
        } else {
            return self
        }
    }
    
    public func scrollClipDisabledCompability(_ disabled: Bool = true) -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            return self.scrollClipDisabled(disabled)
        } else {
            return self
        }
    }
    
    public func fontDesignCompability(_ design: Font.Design?) -> some View {
        if #available(iOS 16.1, macOS 13.0, tvOS 16.1, watchOS 9.1, *) {
            return self.fontDesign(design)
        } else {
            return self
        }
    }
}
