import Foundation
import UIKit

// MARK: Shadows struct
public struct Shadow {
    
    public let shadowColor: UIColor
    public let shadowOffset: CGSize
    public let shadowRadius: CGFloat
    public let shadowOpacity: Float
    public let masksToBound: Bool?
    
    public init(shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float, masksToBound: Bool?) {
        
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.masksToBound = masksToBound
    }
}

// MARK: UIView extension
public extension UIView {
    
    private struct AssociatedKey {
        static var shadowStyle: Shadow? = nil
    }
    
    public var shadowStyle: Shadow {
        get {
            if let result: Shadow = objc_getAssociatedObject(self, &AssociatedKey.shadowStyle) as? Shadow {
                return result
            } else {
                let result = self.shadowStyle
                self.shadowStyle = result
                return result
            }
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.shadowStyle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.applyShadow(ofStyle: self.shadowStyle)
        }
    }
    
    public func applyShadow(ofStyle style: Shadow) {
        self.layer.shadowColor = style.shadowColor.cgColor
        self.layer.shadowOffset = style.shadowOffset
        self.layer.shadowRadius = style.shadowRadius
        self.layer.shadowOpacity = style.shadowOpacity
        if style.masksToBound != nil {
            self.layer.masksToBounds = style.masksToBound!
        }
    }
}
