import SwiftUI

struct MimicrateCloseButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote.bold())
                .foregroundColor(.gray)
                .padding(7)
                .background {
                    Circle()
                }
                .tint(.gray.opacity(0.2))
        }
    }
}
