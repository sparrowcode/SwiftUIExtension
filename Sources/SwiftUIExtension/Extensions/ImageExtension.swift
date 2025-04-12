import Foundation
import SwiftUI

extension Image {
    
    public static func load(url: URL, completion: @escaping (Image?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            if let data = try? Data(contentsOf: url) {
                
                #if canImport(UIKit)
                let songArtwork = UIImage(data: data) ?? UIImage()
                completion(Image(uiImage: songArtwork))
                #endif
                
                #if canImport(AppKit) && !targetEnvironment(macCatalyst)
                let songArtwork = NSImage(data: data) ?? NSImage()
                completion(Image(nsImage: songArtwork))
                #endif
                
                completion(nil)
            }
        }
    }
}
