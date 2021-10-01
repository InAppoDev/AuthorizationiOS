//
//  FontExtension.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

extension UIFont {
    
    enum FamilyFont: String {
        case beVietnam = "BeVietnam-"
    }
    
    enum AssetsFont: String {
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case semibold = "SemiBold"
        case light = "Light"
        case medium = "Medium"
        case italic = "Italic"
        case regular = "Regular"
    }
    
    static func appFont(familyFont: FamilyFont = .beVietnam, name: AssetsFont, size: CGFloat = 14) -> UIFont {
        
        guard let font = UIFont(name: familyFont.rawValue + name.rawValue, size: size) else {
            print("Error: font \(familyFont.rawValue + name.rawValue) not found")
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
}
