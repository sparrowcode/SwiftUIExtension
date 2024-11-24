import SwiftUI

/**
 Idea have to reusable basic style of modal sheet content with title+descrition & action button.
 */
public struct ModalSheetContentView<Content: View, ActionContent: View>: View {
    
    let title: String
    let description: String?
    let content: () -> Content
    let actionContent: () -> ActionContent
    let actionEnabled: Bool
    let action: () -> Void
    let dismissable: Bool
    
    public init(
        title: String,
        description: String?,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder actionContent: @escaping () -> ActionContent,
        actionEnabled: Bool,
        action: @escaping () -> Void,
        dismissable: Bool
    ) {
        self.title = title
        self.description = description
        self.content = content
        self.actionContent = actionContent
        self.actionEnabled = actionEnabled
        self.action = action
        
        self.dismissable = dismissable
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            
            VStack(alignment: .center) {
                Text(title)
                    .font(.title.weight(.bold))
                
                if let description {
                    Text(description)
                }
            }
            
            FixedSpacer(height: Spaces.default_double)
            content()
            FixedSpacer(height: Spaces.default_double)
            
            Button {
                action()
            } label: {
                actionContent()
            }
            .buttonStyle(.large(.tinted))
            .disabled(!actionEnabled)
        }
        .multilineTextAlignment(.center)
    }
}
