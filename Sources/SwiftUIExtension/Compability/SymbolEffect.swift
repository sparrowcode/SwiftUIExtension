import SwiftUI

extension View {
    
    public func symbolEffectCompability(_ model: SymbolEffectCompability) -> some View {
        if #available(iOS 17, watchOS 10.0, *) {
            return self.symbolEffect(.pulse)
        } else {
            return self
        }
    }
}

public enum SymbolEffectCompability {
    
    case pulse
}
