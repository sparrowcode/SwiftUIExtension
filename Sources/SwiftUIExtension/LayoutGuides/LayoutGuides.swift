#if os(iOS) || os(tvOS)
import SwiftUI

extension View {
    
    public func fitGuide(_ guide: LayoutGuide, padding: LayoutPadding = .view) -> some View {
        self.modifier(FitGuide(with: guide, to: padding))
    }
}

public enum LayoutGuide {
    
    case layoutMargings
    case readableMargins
}

public enum LayoutPadding {
    
    case scroll
    case view
}

// MARK: - Private

internal struct FitGuide: ViewModifier {
    
    @State var layoutMargins: EdgeInsets = .init()
    @State var readableMargins: EdgeInsets = .init()
    
    private let guide: LayoutGuide
    private let padding: LayoutPadding
    
    init(with guide: LayoutGuide, to padding: LayoutPadding) {
        self.guide = guide
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        switch guide {
        case .layoutMargings:
            
            switch padding {
            case .scroll:
                if #available(iOS 17.0, *) {
                    content
                        .background(
                            LayoutGuidesObserverView(
                                layoutMarginsDidChanged: {
                                    layoutMargins = $0
                                }
                            )
                        )
                        .contentMargins(.leading, layoutMargins.leading, for: .scrollContent)
                        .contentMargins(.trailing, layoutMargins.trailing, for: .scrollContent)
                } else {
                    content
                }
            case .view:
                content
                    .background(
                        LayoutGuidesObserverView(
                            layoutMarginsDidChanged: {
                                layoutMargins = $0
                            }
                        )
                    )
                    .padding(.leading, layoutMargins.leading)
                    .padding(.trailing, layoutMargins.trailing)
            }
            
        case .readableMargins:
            
            switch padding {
            case .scroll:
                if #available(iOS 17.0, *) {
                    content
                        .background(
                            LayoutGuidesObserverView(
                                readableMarginsDidChanged: {
                                    readableMargins = $0
                                }
                            )
                        )
                        .contentMargins(.leading, readableMargins.leading, for: .scrollContent)
                        .contentMargins(.trailing, readableMargins.trailing, for: .scrollContent)
                } else {
                    content
                }
            case .view:
                content
                    .background(
                        LayoutGuidesObserverView(
                            readableMarginsDidChanged: {
                                readableMargins = $0
                            }
                        )
                    )
                    .padding(.leading, readableMargins.leading)
                    .padding(.trailing, readableMargins.trailing)
            }
        }
    }
}
#endif
