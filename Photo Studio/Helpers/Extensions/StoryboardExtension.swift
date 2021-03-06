//
//  StoryboardExtension.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard {
        case splash
        case authorization
        case main
        case filter
        
        var title: String {
            return String(describing: self).firstUppercased
        }
    }
    
    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.title, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        let id = NSStringFromClass(T.self).components(separatedBy: ".").last!
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}

extension StringProtocol {
    
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
