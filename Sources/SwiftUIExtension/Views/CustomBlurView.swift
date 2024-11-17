import UIKit
import SwiftUI

public struct CustomBlurView: View {
    
    let radius: CGFloat
    
    public init(radius: CGFloat) {
        self.radius = radius
    }
    
    public var body: some View {
        WrapperCustomBlurView(radius: self.radius)
    }
}

// MARK: - Private

private struct WrapperCustomBlurView: UIViewRepresentable {
    
    let radius: CGFloat
    
    init(radius: CGFloat) {
        self.radius = radius
    }
    
    func makeUIView(context: Context) -> ALBlurView {
        ALBlurView()
    }
    
    func updateUIView(_ uiView: ALBlurView, context: Context) {
        uiView.blurRadius = radius
    }
}

private class ALBlurView: UIView {
    
    private enum Constants {
        static let blurRadiusKey = "blurRadius"
        static let colorTintKey = "colorTint"
        static let colorTintAlphaKey = "colorTintAlpha"
    }
    
    // MARK: - Public
    
    /// Blur radius. Defaults to `10`
    open var blurRadius: CGFloat = 10.0 {
        didSet {
            _setValue(blurRadius, forKey: Constants.blurRadiusKey)
        }
    }
    
    /// Tint color. Defaults to `nil`
    open var colorTint: UIColor? {
        didSet {
            _setValue(colorTint, forKey: Constants.colorTintKey)
        }
    }
    
    /// Tint color alpha. Defaults to `0.8`
    open var colorTintAlpha: CGFloat = 0.8 {
        didSet {
            _setValue(colorTintAlpha, forKey: Constants.colorTintAlphaKey)
        }
    }
    
    /// Visual effect view layer.
    public var blurLayer: CALayer {
        return visualEffectView.layer
    }
    
    // MARK: - Initialization
    
    public init(
        radius: CGFloat = 10.0,
        color: UIColor? = nil,
        colorAlpha: CGFloat = 0.8) {
            blurRadius = radius
            super.init(frame: .zero)
            backgroundColor = .clear
            setupViews()
            defer {
                blurRadius = radius
                colorTint = color
                colorTintAlpha = colorAlpha
            }
        }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupViews()
        defer {
            blurRadius = 10.0
            colorTint = nil
            colorTintAlpha = 0.8
        }
    }
    
    
    // MARK: - Private
    
    /// Visual effect view.
    private lazy var visualEffectView: UIVisualEffectView = {
        if #available(iOS 14.0, *) {
            return UIVisualEffectView(effect: customBlurEffect_ios14)
        } else {
            return UIVisualEffectView(effect: customBlurEffect)
        }
    }()
    
    /// Blur effect for IOS >= 14
    private lazy var customBlurEffect_ios14: BlurEffect = {
        let effect = BlurEffect.effect(with: .extraLight)
        effect.blurRadius = blurRadius
        return effect
    }()
    
    /// Blur effect for IOS < 14
    private lazy var customBlurEffect: UIBlurEffect = {
        return (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    }()
    
    /// Sets the value for the key on the blurEffect.
    private func _setValue(_ value: Any?, forKey key: String) {
        if #available(iOS 14.0, *) {
            if key == Constants.blurRadiusKey {
                updateViews()
            }
            let subviewClass = NSClassFromString("_UIVisualEffectSubview") as? UIView.Type
            let visualEffectSubview: UIView? = visualEffectView.subviews.filter({ type(of: $0) == subviewClass }).first
            visualEffectSubview?.backgroundColor = colorTint
            visualEffectSubview?.alpha = colorTintAlpha
        } else {
            customBlurEffect.setValue(value, forKeyPath: key)
            visualEffectView.effect = customBlurEffect
        }
    }
    
    /// Setup views.
    private func setupViews() {
        addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    /// Update visualEffectView for ios14+, if we need to change blurRadius
    private func updateViews() {
        if #available(iOS 14.0, *) {
            visualEffectView.removeFromSuperview()
            let newEffect = BlurEffect.effect(with: .extraLight)
            newEffect.blurRadius = blurRadius
            customBlurEffect_ios14 = newEffect
            visualEffectView = UIVisualEffectView(effect: customBlurEffect_ios14)
            setupViews()
        }
    }
}

private class BlurEffect: UIBlurEffect {
    
    public var blurRadius: CGFloat = 10.0
    
    private enum Constants {
        static let blurRadiusSettingKey = "blurRadius"
    }
    
    class func effect(with style: UIBlurEffect.Style) -> BlurEffect {
        let result = super.init(style: style)
        object_setClass(result, self)
        return result as! BlurEffect
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let result = super.copy(with: zone)
        object_setClass(result, Self.self)
        return result
    }
    
    override var effectSettings: AnyObject {
        get {
            let settings = super.effectSettings
            settings.setValue(blurRadius, forKey: Constants.blurRadiusSettingKey)
            return settings
        }
        set {
            super.effectSettings = newValue
        }
    }
}

private var AssociatedObjectHandle: UInt8 = 0

private extension UIVisualEffect {
    
    @objc var effectSettings: AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as AnyObject
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
