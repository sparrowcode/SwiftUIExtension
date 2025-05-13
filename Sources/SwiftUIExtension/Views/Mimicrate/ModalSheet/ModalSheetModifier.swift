#if os(iOS)
import SwiftUI
import SwiftBoost

struct ModalSheetModifier<ModalContent: View, Selection: Hashable>: ViewModifier {
    
    // States
    @Binding private var isPresented: Bool
    @Binding private var selection: Selection
    private let dismissable: Bool
    private let onDismiss: (() -> Void)?
    
    // Content
    private let modalContent: () -> ModalContent
    
    // Private
    @State private var dragOffset: CGSize = .zero
    
    init(isPresented: Binding<Bool>, selection: Binding<Selection>, dismissable: Bool, onDismiss: (() -> Void)?, @ViewBuilder modalContent: @escaping () -> ModalContent) {
        self._isPresented = isPresented
        self._selection = selection
        self.dismissable = dismissable
        self.onDismiss = onDismiss
        self.modalContent = modalContent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            
            content
                .zIndex(0)
            
            if isPresented {
                
                // Background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeOut, value: isPresented)
                    .zIndex(1)
                
                // Content
                VStack {
                    Spacer()
                    VStack {
                        modalContent()
                            .transitionBlurReplaceCombability()
                            .padding(.top, Spaces.default_half + Spaces.default_more)
                            .padding(.bottom, Spaces.default_more)
                            .padding(.horizontal, Spaces.default_double)
                            .overlay {
                                if dismissable {
                                    VStack {
                                        MimicrateCloseButton {
                                            isPresented = false
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(Spaces.default_more)
                                }
                            }
                    }
                    .background {
                        Color(uiColor: .secondarySystemGroupedBackground)
                    }
                    .clipShape(.rect(cornerRadius: cornerRadius))
                    .shadow(color: .black.opacity(0.12), radius: 6, x: .zero, y: 6)
                    .shadow(color: .black.opacity(0.15), radius: 16, x: .zero, y: 12)
                    .overlay {
                        let color = Color(uiColor: .tertiarySystemGroupedBackground)
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(color, lineWidth: 1)
                    }
                    .padding(.horizontal, padding)
                    .padding(.bottom, padding)
                    .frame(maxWidth: 440)
                    .offset(y: calculateDragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                dragOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if dragOffset.height > 100 && dismissable {
                                    isPresented = false
                                } else {
                                    withAnimation(.interpolatingSpring(duration: 0.26)) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                    )
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }
        }
        .animation(.smooth(duration: presentDimissDuration), value: isPresented)
        .animation(.default, value: selection)
        .onChange(of: isPresented) { isPresented in
            if !isPresented {
                dragOffset = .zero
                delay(presentDimissDuration) {
                    self.onDismiss?()
                }
            }
        }
    }
    
    // MARK: - Private
    
    private var calculateDragOffset: CGFloat {
        let dragDistance = dragOffset.height
        let calm = dragDistance < 0 || !dismissable
        
        if calm {
            let squaredDistance = sqrt(abs(dragDistance))
            if dragDistance < 0 {
                return max(-squaredDistance * 3, dragDistance)
            } else {
                return min(squaredDistance * 2, dragDistance)
            }
        } else {
            return dragDistance
        }
    }
    
    // MARK: - Constants
    
    private var padding: CGFloat = 10
    private var cornerRadius: CGFloat { UIScreen.main.displayCornerRadius - padding }
    private var presentDimissDuration: TimeInterval { 0.41 }
}
#endif
