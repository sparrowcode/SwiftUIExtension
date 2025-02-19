import SwiftUI

extension View {
    
    public func symbolEffectCompability(_ model: SymbolEffectCompability) -> some View {
        return self
        /*if #available(iOS 17, *) {
            switch model {
            case .pulse:
                return self.symbolEffect(.pulse)
            default:
                return self
            }
        } else {
            return self
        }*/
    }
    
    public func scrollTargetBehaviorCompability22() -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            return self.scrollTargetBehavior(.viewAligned)
        } else {
            return self
        }
    }
}

public enum SymbolEffectCompability {
    
    case pulse
}

