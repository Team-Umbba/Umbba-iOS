//
//  UILabel+.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

extension UILabel {
    
    func labelWithImg(composition: NSAttributedString..., spacing: CGFloat) {
        let attributedString = NSMutableAttributedString()
        for i in composition {
            attributedString.append(i)
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: style,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
    
    /// 행간 조정 메서드
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: style,
                                       range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    func setLineSpacingWithChaining(lineSpacing: CGFloat) -> UILabel {
        let label = self
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
            label.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
        return label
    }
    
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat) {
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern,
                                   value: spacing,
                                   range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
    
    /// 자간과 행간을 모두 조정하는 메서드
    func setLineAndCharacterSpacing(lineSpacing: CGFloat, characterSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: style,
                                       range: NSMakeRange(0, attributedStr.length))
            attributedStr.addAttribute(NSAttributedString.Key.kern,
                                       value: characterSpacing,
                                       range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    /// 라벨 일부 font 변경해주는 함수
    /// - targerString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - font에는 targetString에 적용하고자 하는 UIFont를 넣어주세요
    func partFontChange(targetString: String, font: UIFont) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    /// 라벨 일부 textColor 변경해주는 함수
    /// - targetString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - textColor에는 targetString에 적용하고자 하는 특정 UIColor에 넣어주세요
    func partColorChange(targetString: String, textColor: UIColor) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
        self.attributedText = attributedString
    }
    
    func htmlToString(_ targetString: String) -> NSAttributedString? {
        let text = targetString
        
        guard let data = text.data(using: .utf8) else {
            return NSAttributedString()
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func setAttributedText(targetFontList: [String: UIFont],
                           targetColorList: [String: UIColor]) {
        let fullText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        for dic in targetFontList {
            let range = (fullText as NSString).range(of: dic.key)
            attributedString.addAttribute(.font, value: dic.value, range: range)
        }
        
        for dic in targetColorList {
            let range = (fullText as NSString).range(of: dic.key)
            attributedString.addAttribute(.foregroundColor, value: dic.value, range: range)
        }
        self.attributedText = attributedString
    }
    
    /// 라벨 일부 font 변경하면서 행간도 조정하는 함수
    /// - lineSpacing에는 적용하고자 하는 값을 넣어주세요
    /// - targerString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - font에는 targetString에 적용하고자 하는 UIFont를 넣어주세요
    func setLineSpacingPartFontChange(lineSpacing: CGFloat, targetString: String, font: UIFont) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    /// 라벨 일부 font 변경 및 밑줄 추가해주는 함수
    /// - targerString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - font에는 targetString에 적용하고자 하는 UIFont를 넣어주세요
    func setUnderlinePartFontChange(targetString: String, font: UIFont) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.attributedText = attributedString
    }
    
    /// 라벨 내 특정 문자열의 CGRect 반환
    /// - Parameter subText: CGRect값을 알고 싶은 특정 문자열
    func boundingRectForCharacterRange(subText: String) -> CGRect? {
        guard let attributedText = attributedText else { return nil }
        guard let text = self.text else { return nil }
        
        guard let subRange = text.range(of: subText) else { return nil }
        let range = NSRange(subRange, in: text)
        
        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: intrinsicContentSize)
        textContainer.lineFragmentPadding = 0.0
        layoutManager.addTextContainer(textContainer)
        var glyphRange = NSRange()
        layoutManager.characterRange(
            forGlyphRange: range,
            actualGlyphRange: &glyphRange
        )
        
        return layoutManager.boundingRect(
            forGlyphRange: glyphRange,
            in: textContainer
        )
    }
    
    func countCurrentLines() -> Int {
        guard let text = self.text as NSString? else { return 0 }
        guard let font = self.font              else { return 0 }
        
        var attributes = [NSAttributedString.Key: Any]()
        
        if let kernAttribute = self.attributedText?.attributes(at: 0, effectiveRange: nil).first(where: { key, _ in
            return key == .kern
        }) {
            attributes[.kern] = kernAttribute.value
        }
        attributes[.font] = font
        
        let labelTextSize = text.boundingRect(
            with: CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )

        return Int(ceil(labelTextSize.height / font.lineHeight))
    }
}
