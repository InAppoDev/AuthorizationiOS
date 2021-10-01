//
//  TextFieldTableViewCell.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 29.11.2020.
//

import UIKit
import MaterialComponents

protocol TextFieldTableViewCellProtocol {
    func display(title: String?)
    func display(text: String?)
    func display(error: String?)
    func display(isPasword: Bool)
    func display(textContent: UITextContentType?)
    func display(keybordType: UIKeyboardType)
    var textHandler: ((String) -> ())? { get set }
}

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: MDCFilledTextField!
    
    var textHandler: ((String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
    private func resetContent() {
        textField.text = nil
        textField.trailingAssistiveLabel.text = nil
        textField.trailingView = nil
        textField.trailingViewMode = .never
    }
    
    private func setupView() {
        textField.setFilledBackgroundColor(.clear, for: .normal)
        textField.setFilledBackgroundColor(.clear, for: .editing)
        textField.setUnderlineColor(.appColor(.blueApp), for: .editing)
        textField.setUnderlineColor(.appColor(.borderText), for: .normal)
        textField.setFloatingLabelColor(.appColor(.greyText), for: .normal)
        textField.setFloatingLabelColor(.appColor(.blueApp), for: .editing)
        textField.setNormalLabelColor(.appColor(.textColor), for: .normal)
        textField.setTextColor(.appColor(.textColor), for: .editing)
        textField.setTextColor(.appColor(.textColor), for: .normal)
        textField.setTrailingAssistiveLabelColor(.red, for: .normal)
        textField.setTrailingAssistiveLabelColor(.red, for: .editing)
        textField.tintColor = .appColor(.blueApp)
        textField.font = .appFont(familyFont: .beVietnam, name: .regular, size: 14)
        textField.leadingView = nil
        textField.label.font = .appFont(familyFont: .beVietnam, name: .regular, size: 12)
        textField.trailingAssistiveLabel.font = .appFont(familyFont: .beVietnam, name: .regular, size: 12)
    }
    
    @IBAction func enterText(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        print(text)
        textHandler?(text)
    }
    
    @objc func pressShowButton(sender: UIButton) {
        if sender.isSelected {
            sender.setImage(.appImage(.hidePassword), for: .normal)
        } else {
            sender.setImage(.appImage(.showPassword), for: .normal)
        }
        textField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
}

extension TextFieldTableViewCell: TextFieldTableViewCellProtocol {
    
    func display(title: String?) {
        textField.label.text = title
    }
    
    func display(text: String?) {
        textField.text = text
    }
    
    func display(isPasword: Bool) {
        textField.isSecureTextEntry = isPasword
        if isPasword {
            let showButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            showButton.setImage(.appImage(.hidePassword), for: .normal)
            showButton.addTarget(self, action: #selector(pressShowButton(sender:)), for: .touchUpInside)
            textField.trailingView = showButton
            textField.trailingViewMode = .always
        }
    }
    
    func display(error: String?) {
        textField.trailingAssistiveLabel.text = error
    }
    
    func display(textContent: UITextContentType?) {
        textField.textContentType = textContent
    }
    
    func display(keybordType: UIKeyboardType) {
        textField.keyboardType = keybordType
    }
}
