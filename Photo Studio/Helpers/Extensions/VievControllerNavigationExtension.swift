//
//  VievControllerNavigationExtension.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

extension UIViewController {
    
    func popToRootVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func popVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func presentVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.present(vc, animated: animated, completion: nil)
        }
    }
    
    func dismiss(animated: Bool) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
