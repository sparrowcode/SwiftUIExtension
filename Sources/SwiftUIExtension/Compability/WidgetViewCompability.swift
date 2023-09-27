import SwiftUI

#if canImport(WidgetKit)
import WidgetKit

extension View {
    
    public func containerBackgroundForWidgetCompability<Background>(background: @escaping () -> Background) -> some View where Background: View {
        modifier(ContainerBackgroundForWidgetCompabilityModifier(background: background))
    }

    public func containerBackgroundForWidget<Background>(@ViewBuilder background: @escaping () -> Background) -> some View where Background: View {
        modifier(ContainerBackgroundForWidgetModifier(background: background))
    }
}

struct ContainerBackgroundForWidgetCompabilityModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, watchOS 10.0, watchOSApplicationExtension 10.0, macOS 14.0, *) {
            content
                .containerBackground(for: .widget) {
                    background()
                }
        } else {
            content
        }
    }
}

struct ContainerBackgroundForWidgetModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, watchOS 10.0, watchOSApplicationExtension 10.0, macOS 14.0, *) {
            content
                .containerBackground(for: .widget) {
                    background()
                }
        } else {
            ZStack {
                background()
                content
                    .padding()
            }
        }
    }
}

#endif
