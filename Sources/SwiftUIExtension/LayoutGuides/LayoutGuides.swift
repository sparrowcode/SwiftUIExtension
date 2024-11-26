import SwiftUI

extension View {
    
    public func fitToReadableContentWidth(alignment: Alignment = .center) -> some View {
        self.modifier(FitLayoutGuidesWidth(alignment: alignment, kind: .readableContent))
    }
    
    public func fitToLayoutMarginsWidth(alignment: Alignment = .center) -> some View {
        self.modifier(FitLayoutGuidesWidth(alignment: alignment, kind: .layoutMargins))
    }
    
    public func measureLayoutGuides() -> some View {
        self.modifier(LayoutGuidesModifier())
    }
}

public struct WithLayoutMargins<Content>: View where Content: View {
    
    let content: (EdgeInsets) -> Content
    
    public init(@ViewBuilder content: @escaping (EdgeInsets) -> Content) {
        self.content = content
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = { _ in content() }
    }
    
    public var body: some View {
        InsetContent(content: content)
            .measureLayoutGuides()
    }
    
    private struct InsetContent: View {
        
        let content: (EdgeInsets) -> Content
        
        @Environment(\.layoutMarginsInsets) var layoutMarginsInsets
        
        var body: some View {
            content(layoutMarginsInsets)
        }
    }
}

// MARK: - Private

internal struct FitLayoutGuidesWidth: ViewModifier {
    
    enum Kind {
        case layoutMargins
        case readableContent
    }
    
    let alignment: Alignment
    let kind: Kind
    
    func body(content: Content) -> some View {
        switch kind {
        case .layoutMargins:
            content.modifier(InsetLayoutMargins(alignment: alignment))
                .measureLayoutGuides()
        case .readableContent:
            content.modifier(InsetReadableContent(alignment: alignment))
                .measureLayoutGuides()
        }
    }
    
    private struct InsetReadableContent: ViewModifier {
        
        let alignment: Alignment
        @Environment(\.readableContentInsets) var readableContentInsets
        
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, alignment: alignment)
                .padding(.leading, readableContentInsets.leading)
                .padding(.trailing, readableContentInsets.trailing)
        }
    }
    
    private struct InsetLayoutMargins: ViewModifier {
        
        let alignment: Alignment
        @Environment(\.layoutMarginsInsets) var layoutMarginsInsets
        
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, alignment: alignment)
                .padding(.leading, layoutMarginsInsets.leading)
                .padding(.trailing, layoutMarginsInsets.trailing)
        }
    }
}

internal struct LayoutGuidesModifier: ViewModifier {
    
    @State var layoutMarginsInsets: EdgeInsets = .init()
    @State var readableContentInsets: EdgeInsets = .init()
    
    func body(content: Content) -> some View {
        content
            #if os(iOS) || os(tvOS)
            .environment(\.layoutMarginsInsets, layoutMarginsInsets)
            .environment(\.readableContentInsets, readableContentInsets)
            .background(
                LayoutGuidesObserverView(
                    onLayoutMarginsGuideChange: {
                        layoutMarginsInsets = $0
                    },
                    onReadableContentGuideChange: {
                        readableContentInsets = $0
                    })
            )
            #endif
    }
}

