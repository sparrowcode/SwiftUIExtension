import SwiftUI

extension ButtonStyle where Self == LargeButtonStyle {
    
    public static func large(_ colorise: ButtonColorise) -> Self {
        return LargeButtonStyle(colorise)
    }
}

public struct LargeButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let colorise: ButtonColorise
    
    init(_ colorise: ButtonColorise) {
        self.colorise = colorise
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(colorise.foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .background {
                colorise.backgroundColor
                    .clipShape(.rect(cornerRadius: 12))
            }
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.default, value: configuration.isPressed)
            .opacity(isEnabled ? 1 : 0.4)
            .animation(.default, value: isEnabled)
    }
}

public enum ButtonColorise {
    
    case colorful
    case tinted
    case grayed
    
    var foregroundColor: Color {
        switch self {
        case .colorful:
            return .white
        case .tinted:
            return .accentColor
        case .grayed:
            return .accentColor
        }
    }
    var backgroundColor: Color {
        switch self {
        case .colorful:
            return .accentColor
        case .tinted:
            return .accentColor.opacity(0.12)
        case .grayed:
            return .gray.opacity(0.15)
        }
    }
}
