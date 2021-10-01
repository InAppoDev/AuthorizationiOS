//
//  ColorExtension.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

extension UIColor {
    
    enum AssetsColor: String {
        case blueApp
        case textColor
        case borderText
        case greyText
        case appWhite
        case skipButtonBackground
        case confirmButton
        case whiteTransparentforFields
    }
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        
        guard let color = UIColor(named: name.rawValue) else {
            print("Error: color \(name.rawValue) not found")
            return .red
        }
        
        return color
    }
}

