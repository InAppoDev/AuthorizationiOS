//
//  LoginPresenter.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 29.11.2020.
//

import UIKit

protocol LoginPresenterProtocol {
    init(view: LoginViewControllerProtocol, isLogin: Bool)
    func configurateCell(_ cell: TextFieldTableViewCellProtocol, item: Int)
    func getCountItems() -> Int
    func pressLogin(isLogin: Bool)
    func pressConfirm()
    func onLoadView()
}

class LoginPresenter: LoginPresenterProtocol {
    
    private unowned let view: LoginViewControllerProtocol

    required init(view: LoginViewControllerProtocol, isLogin: Bool) {
        self.view = view
        self.isLogin = isLogin
    }
    
    // MARK: - Properties
    private var isLogin: Bool
    private var dataSignUp = [SignUpItems : String]()
    private var dataSignIn = [SignInItems : String]()
    private let authApi = AuthApi()
    
    // MARK: - UI
    func onLoadView() {
        self.view.setupUI(isLogin: isLogin)
    }
    
    func configurateCell(_ cell: TextFieldTableViewCellProtocol, item: Int) {
        if isLogin {
            guard let type = SignInItems.init(rawValue: item) else { return }
            
            cell.display(isPasword: type.isPasword)
            cell.display(title: type.title)
            cell.display(keybordType: type.keybordType)
            cell.display(textContent: type.contentType)
            cell.display(text: dataSignIn[type])
            var cell = cell
            cell.textHandler = { [weak self] text in
                guard let self = self else { return }
                
                self.dataSignIn[type] = text
            }
        } else {
            guard let type = SignUpItems.init(rawValue: item) else { return }
            
            cell.display(isPasword: type.isPasword)
            cell.display(title: type.title)
            cell.display(keybordType: type.keybordType)
            cell.display(textContent: type.contentType)
            cell.display(text: dataSignUp[type])
            var cell = cell
            cell.textHandler = { [weak self] text in
                guard let self = self else { return }
                
                self.dataSignUp[type] = text
            }
        }
    }
    
    func getCountItems() -> Int {
        return isLogin ? SignInItems.allCases.count : SignUpItems.allCases.count
    }
    
    // MARK: - Actions
    func pressLogin(isLogin: Bool) {
        self.isLogin = isLogin
        self.view.setupUI(isLogin: self.isLogin)
    }
    
    func pressConfirm() {
        if isLogin {
            self.login()
        } else {
            self.register()
        }
    }
    
    // MARK: - API
    private func login() {
        
    }
    
    private func register() {
        
    }
    
}
