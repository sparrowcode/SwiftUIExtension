import SwiftUI

public struct ModalHeaderView: View {
    
    let topView: AnyView
    
    let systemIconName: String?
    let titleText: String
    let bodyText: String
    
    public init<TopView: View>(@ViewBuilder topView: @escaping () -> TopView, title: String, body: String) {
        self.systemIconName = nil
        self.topView = AnyView(topView())
        self.titleText = title
        self.bodyText = body
    }
    
    public init(systemIconName: String, title: String, body: String) {
        self.init(topView: {
            Image(systemName: systemIconName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .font(.body.weight(.regular))
                .frame(width: 52)
        }, title: title, body: body)
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            
            topView
            
            FixedSpacer(height: 32)
            
            VStack(spacing: 8) {
                Text(titleText)
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.primary)
                Text(bodyText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }
}
