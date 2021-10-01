//
//  LoginViewController.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 29.11.2020.
//

import UIKit

protocol LoginViewControllerProtocol: BaseViewControllerProtocol {
    func setupUI(isLogin: Bool)
}

class LoginViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var bottomTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.onLoadView()
        setupViews()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        self.view.setGradientBackground()
        setupTableView()
        bottomTextView.delegate = self
        confirmButton.setGradientButton()
    }
    
    private func setupTableView() {
        tableView.register(TextFieldTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction func pressConfirmButton(_ sender: UIButton) {
        presenter.pressConfirm()
    }
    
}

extension LoginViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "SignIn" {
            presenter.pressLogin(isLogin: true)
        } else if URL.absoluteString == "SignUp" {
            presenter.pressLogin(isLogin: false)
        }
        return false
    }
    
}

extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCountItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(TextFieldTableViewCell.self, indexPath)
        presenter.configurateCell(cell, item: indexPath.row)
        return cell
    }
    
    
}

extension LoginViewController: UITableViewDelegate {
    
}

extension LoginViewController: LoginViewControllerProtocol {
    
    func setupUI(isLogin: Bool) {
        if isLogin {
            titleLabel.text = "Login to your account"
            bottomTextView.hyperLink(originalText: "Don’t have an account? Sign Up", hyperLink: ["Sign Up"], urlString: ["SignUp"], styleAligment: .center)
            signUpButton.viewBorder(color: .appColor(.borderText), width: 1)
            signInButton.viewBorder(color: .appColor(.blueApp), width: 1)
        } else {
            titleLabel.text = "Create an account"
            bottomTextView.hyperLink(originalText: "Already have an account? Sign In", hyperLink: ["Sign In"], urlString: ["SignIn"], styleAligment: .center)
            signUpButton.viewBorder(color: .appColor(.blueApp), width: 1)
            signInButton.viewBorder(color: .appColor(.borderText), width: 1)
        }
        tableView.reloadData()
    }
}
