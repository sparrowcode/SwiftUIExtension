import SwiftUI

public extension ButtonStyle where Self == SideBarActionButtonStyle {
    
    static var sideBarAction: Self { SideBarActionButtonStyle() }
}

public struct SideBarActionButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
            .opacity(configuration.isPressed ? 0.4 : 1)
    }
}

