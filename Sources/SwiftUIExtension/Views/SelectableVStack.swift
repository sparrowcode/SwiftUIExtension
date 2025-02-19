/*import SwiftUI

public struct SelectableVStack<Data, Content>: View where Data : RandomAccessCollection, Data.Element : Identifiable, Data.Element : Equatable, Content: View {
    
    @Binding private var selectedElement: Data.Element
    
    private let data: Data
    private let spacing: CGFloat
    private let content: (Data.Element, Bool) -> Content
    
    public init(
        data: Data,
        selectedElement: Binding<Data.Element>,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content
    ) {
        self.data = data
        self.spacing = spacing
        self._selectedElement = selectedElement
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(data) { element in
                content(element, selectedElement == element)
            }
        }
    }
}*/

