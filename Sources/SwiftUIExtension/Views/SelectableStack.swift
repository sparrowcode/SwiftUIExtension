import SwiftUI

public struct SelectableStack<Data, Content>: View where Data : RandomAccessCollection, Data.Element : Identifiable, Data.Element : Equatable, Content: View {
    
    private let alignment: Alignment
    private let space: CGFloat
    private let data: Data
    private let content: (Data.Element, Bool) -> Content
    
    @Binding private var selectedElement: Data.Element
    
    public init(
        alignment: Alignment,
        space: CGFloat = Spaces.default_half,
        data: Data,
        selectedElement: Binding<Data.Element>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content
    ) {
        self.alignment = alignment
        self.space = space
        self.data = data
        self._selectedElement = selectedElement
        self.content = content
    }
    
    public var body: some View {
        switch alignment {
        case .vertical:
            VStack(spacing: space) {
                ForEach(data) { element in
                    content(element, selectedElement == element)
                }
            }
        case .horizontal:
            EmptyView()
        }
    }
    
    public enum Alignment {
        
        case vertical
        case horizontal
    }
}
