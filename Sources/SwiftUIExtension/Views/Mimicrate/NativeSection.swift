import SwiftUI
import SafeSFSymbols
import SwiftUIIntrospect

public struct NativeSection<Content: View, Detail: View>: View {
    
    let title: String
    @ViewBuilder let content: () -> Content
    let detail: (() -> Detail)?
    
    public init(
        _ title: String,
        @ViewBuilder content: @escaping () -> Content,
        detail: (() -> Detail)? = nil
    ) {
        self.title = title
        self.content = content
        self.detail = detail
    }
    
    public var body: some View {
        VStack(spacing: Spaces.default_less) {
            Section {
                content()
            } header: {
                HStack(spacing: Spaces.step) {
                    
                    if let detail = self.detail {
                        #if os(iOS)
                        NavigationLink {
                            detail()
                                .navigationTitle(title)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            HStack(alignment: .firstTextBaseline, spacing: Spaces.step) {
                                Text(title)
                                    .foregroundColor(.primary)
                                    .font(.title2)
                                    .fontWeightCompability(.bold)
                                Image(.chevron.right)
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .fontWeightCompability(.heavy)
                            }
                            .baselineOffsetCompability(-1)
                            .padding(.leading, Spaces.default)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                        #elseif os(visionOS)
                        HStack(alignment: .center, spacing: Spaces.default_half) {
                            
                            Text(title)
                                .foregroundColor(.primary)
                                .font(.title2)
                                .fontWeightCompability(.bold)
                            
                            NavigationLink {
                                detail()
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                Image(.chevron.right)
                                    .foregroundColor(.primary)
                                    .font(.footnote)
                                    .fontWeightCompability(.bold)
                            }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.circle)
                            .controlSize(.mini)
                            
                            Spacer()
                        }
                        #endif
                    } else {
                        Text(title)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .fontWeightCompability(.bold)
                            .padding(.leading, Spaces.default)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
    
    private var space: CGFloat {
        #if os(iOS)
        return Spaces.default_less
        #elseif os(visionOS)
        return Spaces.step
        #endif
    }
}

extension NativeSection where Detail == Never {

    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.init(title, content: content, detail: nil)
    }
}
