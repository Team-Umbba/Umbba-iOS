//
//  FontLiterals.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

struct FontName {
    static let Cafe24Regular = "Cafe24ClassicType-Regular-OTF"
    static let PretendardBold = "Pretendard-Bold"
    static let PretendardSemiBold = "Pretendard-SemiBold"
    static let PretendardRegular = "Pretendard-Regular"
}

extension UIFont {
    @nonobjc class func PretendardBold(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.PretendardBold, size: size)!
    }
    
    @nonobjc class func PretendardSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.PretendardSemiBold, size: size)!
    }
    
    @nonobjc class func PretendardRegular(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.PretendardRegular, size: size)!
    }
    
    @nonobjc class func Cafe24Regular(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.Cafe24Regular, size: size)!
    }
}
