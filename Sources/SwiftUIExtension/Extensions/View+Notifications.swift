import SwiftUI
import Combine

extension View {
    
    public func onReceive(
        _ name: Notification.Name,
        perform action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
            self.onReceive(NotificationCenter.default.publisher(for: name), perform: action)
        }
    
    public func onReceive(
        _ names: Notification.Name...,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        perform action: @escaping (Notification) -> Void
    ) -> some View {
        
        let mergedPublisher = names.map { name in
            center.publisher(for: name, object: object)
        }.reduce(Empty<Notification, Never>().eraseToAnyPublisher()) { merged, publisher in
            merged.merge(with: publisher).eraseToAnyPublisher()
        }
        
        return self.onReceive(mergedPublisher, perform: action)
    }
}
