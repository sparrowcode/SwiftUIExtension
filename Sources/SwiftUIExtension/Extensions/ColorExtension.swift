import SwiftUI
import SwiftBoost

extension View {

    #if canImport(UIKit)
    @available(iOS 15.0, watchOS 8.0, *)
    public func foregroundColor(_ color: UIColor) -> some View {
        self.foregroundColor(.init(uiColor: color))
    }
    #endif
}
