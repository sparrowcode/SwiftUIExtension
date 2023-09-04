import SwiftUI

public struct ExpandableSection<Content: View, Header: View>: View {
    
    @State private var isExpanded = true
    
    private var content: () -> Content
    private var header: () -> Header
    
    private let isExpandable: Bool
    
    public init(isExpandable: Bool, @ViewBuilder content: @escaping () -> Content, @ViewBuilder header: @escaping () -> Header) {
        self.isExpandable = isExpandable
        self.content = content
        self.header = header
    }
    
    public var body: some View {
        if isExpandable {
            if #available(iOS 17.0, macOS 14.0, watchOS 10.0, *) {
                Section(isExpanded: $isExpanded) {
                    content()
                } header: {
                    header()
                }
            } else {
                Section {
                    content()
                } header: {
                    header()
                }
            }
        } else {
            Section {
                content()
            } header: {
                header()
            }
        }
    }
}

public extension ExpandableSection where Header == EmptyView {}
