import SwiftUI

extension View {
    
    public func sensoryFeedbackCompability<T>(_ feedback: SensoryFeedbackCompability, trigger: T) -> some View where T : Equatable {
        self.modifier(SensoryFeedbackModifier(feedback, trigger: trigger))
    }
}

struct SensoryFeedbackModifier<T: Equatable>: ViewModifier {
    
    let feedback: SensoryFeedbackCompability
    let trigger: T
    
    init(_ feedback: SensoryFeedbackCompability, trigger: T) {
        self.feedback = feedback
        self.trigger = trigger
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, watchOS 10.0, *) {
            content
                .sensoryFeedback(.selection, trigger: trigger)
        } else {
            content
        }
    }
}

public enum SensoryFeedbackCompability {
    
    case selection
}

/*
struct SensoryFeedbackModifier: ViewModifier {
    
    let selectedElement: AnyHasherable

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content.sensoryFeedback(.selection, trigger: selectedElement)
        } else {
            content
        }
    }
}

extension View {
    func applySensoryFeedback(selectedElement: AnyHasherable) -> some View {
        self.modifier(SensoryFeedbackModifier(selectedElement: selectedElement))
    }
}
*/
