//
//  ImageExtension.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

extension UIImage {
    
    enum AssetImage: String {
        
        //Base
        case logo
        case hidePassword
        case showPassword
        case bg
        case back
        case toFavorites
        case inFavorites
        
        //Onboarding
        case onboardigPage1
        case onboardigPage2
        
        //Filter
        case close
        case confirmImage
        
        //TabBarRegular
        case bookingsRegular
        case favoritesRegular
        case searchRegular
        case settingsRegular
        case walletRegular
        
    }
    
    static func appImage(_ name: AssetImage) -> UIImage {
        
        guard let image = UIImage(named: name.rawValue) else {
            print("Error: image \(name.rawValue) not found")
            return UIImage()
        }
        
        return image
    }
}
