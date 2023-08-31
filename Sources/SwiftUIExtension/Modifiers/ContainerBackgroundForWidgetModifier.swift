import SwiftUI
import WidgetKit

extension View {
    
    public func containerBackgroundForWidget<Background>(background: @escaping () -> Background) -> some View where Background: View {
        modifier(ContainerBackgroundForWidgetModifier(background: background))
    }
}

struct ContainerBackgroundForWidgetModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *) {
            content
                .containerBackground(for: .widget) {
                    //AccessoryWidgetBackground()
                    background()
                }
        } else {
            content
        }
    }
}
