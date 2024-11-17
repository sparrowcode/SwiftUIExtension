import SwiftUI

extension View {
    
    public func onReceive(notification name: Notification.Name, perform action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: name), perform: action)
    }
}
