#if os(iOS)
import SwiftUI

extension View {
    
    public func modalSheet<Content, Selection: Hashable>(
        isPresented: Binding<Bool>,
        selection: Binding<Selection>,
        dismissable: Bool,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        
        let sheet = ModalSheetModifier(
            isPresented: isPresented,
            selection: selection,
            dismissable: dismissable,
            onDismiss: onDismiss,
            modalContent: content
        )
        
        return self.modifier(sheet)
    }
    
    public func modalSheet<Content>(
        isPresented: Binding<Bool>,
        dismissable: Bool,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        
        let sheet = ModalSheetModifier(
            isPresented: isPresented,
            selection: .constant(""),
            dismissable: dismissable,
            onDismiss: onDismiss,
            modalContent: content
        )
        
        return self.modifier(sheet)
    }
}
#endif
