//
//  SplashViewController.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    func popToRootVC(animated: Bool)
    func popVC(animated: Bool)
    func pushToVC(_ vc: UIViewController, animated: Bool)
    func presentVC(_ vc: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}

protocol SplashViewControllerProtocol: BaseViewControllerProtocol {
    
}

class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var presenter: SplashPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SplashPresenter(view: self)
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - UI
    
    private func setupViews() {
        self.view.setGradientBackground()
        showLogin()
    }
    
    private func showLogin() {
        Timer.scheduledTimer(withTimeInterval: 1,
                             repeats: false) { timer in
            timer.invalidate()
            let vc = LoginViewController.instance(.authorization)
            vc.presenter = LoginPresenter(view: vc, isLogin: false)
            let nc = UINavigationController.init(rootViewController: vc)
            nc.setNavigationBarHidden(true, animated: false)
            UIApplication.shared.keyWindow?.rootViewController = nc
        }
    }
    
    // MARK: - IBActions
    
}

extension SplashViewController: SplashViewControllerProtocol {
    
}
