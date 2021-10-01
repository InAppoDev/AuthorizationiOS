//
//  SplashPresenter.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import Foundation

protocol SplashPresenterProtocol {
    init(view: SplashViewControllerProtocol)
}

class SplashPresenter: SplashPresenterProtocol {
    
    private unowned let view: SplashViewControllerProtocol

    required init(view: SplashViewControllerProtocol) {
        self.view = view
    }
    
}
