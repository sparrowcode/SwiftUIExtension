import Foundation

public enum Spaces {
    
    public static var step: CGFloat = 4
    
    public static var default_half: CGFloat { self.default / 2 } // 8
    public static var default_less: CGFloat { step * 3 } // 12
    public static var `default`: CGFloat { step * 4 } // 16
    public static var default_more: CGFloat { step * 6 } // 24
    public static var default_double: CGFloat { self.default * 2 } // 32
}
