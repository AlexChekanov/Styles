import Foundation
import UIKit

// MARK: - TextStyles struct
public struct TextStyle {
    
    public var font: UIFont?
    public var foregroundColor: UIColor?
    public var backgroundColor: UIColor?
    
    public var baselineOffset: NSNumber?
    
    public var strikethroughStyle: NSNumber?
    public var strikethroughColorAttributeName: UIColor?
    
    public var underlineStyle: NSNumber?
    public var underlineColor: UIColor?
    
    public var strokeWidth: NSNumber? // NSNumber. In the negative fills the text
    public var strokeColor: UIColor?
    
    public var textEffectAttributeName: String? // f.e.: NSTextEffectLetterpressStyle as NSString
    
    public var ligature: NSNumber?
    public var kern: NSNumber?
    
    // Paragraph
    public var lineBreakMode: NSLineBreakMode?
    public var allowsDefaultTighteningForTruncation: Bool?
    public var hyphenationFactor: Float? // 0.0—1.0
    public var alignment: NSTextAlignment?
    public var lineHeightMultiple: CGFloat?
    
    // Shadow
    public var shadowColor: UIColor?
    public var shadowBlurRadius: CGFloat?
    public var shadowOffset: CGSize?
    
    // Style to attributes converter
    public var attributes: [NSAttributedStringKey: Any] {
        
        var attributes: [NSAttributedStringKey: Any] = [:]
        
        attributes [NSAttributedStringKey.font] = font
        attributes [NSAttributedStringKey.foregroundColor] = foregroundColor
        attributes [NSAttributedStringKey.backgroundColor] = backgroundColor
        attributes [NSAttributedStringKey.baselineOffset] = baselineOffset
        attributes [NSAttributedStringKey.strikethroughStyle] = strikethroughStyle
        attributes [NSAttributedStringKey.strikethroughColor] = strikethroughColorAttributeName
        attributes [NSAttributedStringKey.underlineStyle] = underlineStyle
        attributes [NSAttributedStringKey.underlineColor] = underlineColor
        attributes [NSAttributedStringKey.strokeWidth] = strokeWidth
        attributes [NSAttributedStringKey.strokeColor] = strokeColor
        attributes [NSAttributedStringKey.textEffect] = textEffectAttributeName
        attributes [NSAttributedStringKey.ligature] = ligature
        attributes [NSAttributedStringKey.kern] = kern
        
        // Paragraph
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let lineBreakMode = lineBreakMode { paragraphStyle.lineBreakMode = lineBreakMode }
        
        if let allowsDefaultTighteningForTruncation =  allowsDefaultTighteningForTruncation { paragraphStyle.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation }
        if let hyphenationFactor = hyphenationFactor { paragraphStyle.hyphenationFactor = hyphenationFactor }
        if let alignment = alignment { paragraphStyle.alignment = alignment }
        if let lineHeightMultiple = lineHeightMultiple  { paragraphStyle.lineHeightMultiple = lineHeightMultiple }
        
        attributes [NSAttributedStringKey.paragraphStyle] = paragraphStyle
        
        let shadowStyle = NSShadow()
        if let shadowColor = shadowColor { shadowStyle.shadowColor = shadowColor }
        if let shadowBlurRadius = shadowBlurRadius  { shadowStyle.shadowBlurRadius = shadowBlurRadius }
        if let shadowOffset = shadowOffset { shadowStyle.shadowOffset = shadowOffset }
        
        attributes [NSAttributedStringKey.shadow] = shadowStyle
        
        return attributes
    }
    
}

// MARK: - Basic style
public extension TextStyle {
    
    public static let basic: TextStyle = TextStyle(
        font: nil,
        foregroundColor: nil,
        backgroundColor: nil,
        
        baselineOffset: 0,
        
        strikethroughStyle: nil,
        strikethroughColorAttributeName: nil,
        
        underlineStyle: nil,
        underlineColor: nil,
        
        strokeWidth: nil,
        strokeColor: nil,
        
        textEffectAttributeName: nil,
        
        ligature: 1,
        kern: nil,
        
        lineBreakMode: NSLineBreakMode.byWordWrapping,
        allowsDefaultTighteningForTruncation: true,
        hyphenationFactor: 0.0,
        alignment: NSTextAlignment.natural,
        lineHeightMultiple: nil,
        
        shadowColor: nil,
        shadowBlurRadius: nil,
        shadowOffset: nil
    )
}

// MARK: - Normal style
public extension TextStyle {
    
    public static let normal: TextStyle = TextStyle(
        font: .preferredFont(forTextStyle: .body),
        foregroundColor: .black,
        backgroundColor: .clear,
        
        baselineOffset: 0,
        
        strikethroughStyle: nil,
        strikethroughColorAttributeName: nil,
        
        underlineStyle: nil,
        underlineColor: nil,
        
        strokeWidth: nil,
        strokeColor: nil,
        
        textEffectAttributeName: nil,
        
        ligature: 1,
        kern: nil,
        
        lineBreakMode: NSLineBreakMode.byWordWrapping,
        allowsDefaultTighteningForTruncation: true,
        hyphenationFactor: 0.0,
        alignment: NSTextAlignment.natural,
        lineHeightMultiple: nil,
        
        shadowColor: nil,
        shadowBlurRadius: nil,
        shadowOffset: nil
    )
}

// MARK: - Empty template
public extension TextStyle {
    
    public static var empty: TextStyle {
        
        return TextStyle(
            font: nil,
            foregroundColor: nil,
            backgroundColor: nil,
            
            baselineOffset: nil,
            
            strikethroughStyle: nil,
            strikethroughColorAttributeName: nil,
            
            underlineStyle: nil,
            underlineColor: nil,
            
            strokeWidth: nil,
            strokeColor: nil,
            
            textEffectAttributeName: nil,
            
            ligature: nil,
            kern: nil,
            
            lineBreakMode: nil,
            allowsDefaultTighteningForTruncation: true,
            hyphenationFactor: nil,
            alignment: nil,
            lineHeightMultiple: nil,
            
            shadowColor: nil,
            shadowBlurRadius: nil,
            shadowOffset: nil
        )
    }
}

// MARK: - NSMutableAttributedString extension
public extension NSMutableAttributedString {
    
    private struct AssociatedKey {
        static var style: TextStyle? = nil
    }
    
    public var style: TextStyle {
        get {
            if let result: TextStyle = objc_getAssociatedObject(self, &AssociatedKey.style) as? TextStyle {
                return result
            } else {
                let result = self.style
                self.style = result
                return result
            }
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.style, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.applyAttributes(ofStyle: self.style)
        }
    }
    
    public func applyAttributes(ofStyle style: TextStyle) {
        
        self.addAttributes(style.attributes, range: NSMakeRange(0, self.length))
    }
}
