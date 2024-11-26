import SwiftUI

private struct LayoutMarginsGuidesKey: EnvironmentKey {
    static var defaultValue: EdgeInsets { .init() }
}

private struct ReadableContentGuidesKey: EnvironmentKey {
    static var defaultValue: EdgeInsets { .init() }
}

extension EnvironmentValues {
    
    public var layoutMarginsInsets: EdgeInsets {
        get { self[LayoutMarginsGuidesKey.self] }
        set { self[LayoutMarginsGuidesKey.self] = newValue }
    }
    
    public var readableContentInsets: EdgeInsets {
        get { self[ReadableContentGuidesKey.self] }
        set { self[ReadableContentGuidesKey.self] = newValue }
    }
}
