//
//  Extensions.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit
import MaterialComponents

extension UIViewController {
    
    class func instance(_ storyboard: UIStoryboard.Storyboard) -> Self {
        
        let storyboard = UIStoryboard(storyboard: storyboard)
        let viewController = storyboard.instantiateViewController(self)
        
        return viewController
    }
    
    func showChoiceAlert(title: String? , message: String?, customActions: [UIAlertAction]) {
        self.showAlert(title: title, message: message, customActions: customActions, completion: {})
    }
    
    func showAlert(title: String?, message: String?, customActions: [UIAlertAction] = [], completion: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            if customActions.isEmpty {
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in completion()}))
            } else {
                for action in customActions {
                    alert.addAction(action)
                }
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func hideNavigationBar(hidden: Bool) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: false)
    }
    
    func configurateTextField(_ textField: MDCFilledTextField, title: String?, text: String? = nil) {
        textField.setFilledBackgroundColor(.clear, for: .normal)
        textField.setFilledBackgroundColor(.clear, for: .editing)
        textField.setUnderlineColor(.appColor(.blueApp), for: .editing)
        textField.setUnderlineColor(.appColor(.borderText), for: .normal)
        textField.label.text = title
        textField.text = text
        textField.setFloatingLabelColor(.appColor(.greyText), for: .normal)
        textField.setFloatingLabelColor(.appColor(.blueApp), for: .editing)
        textField.setNormalLabelColor(.appColor(.textColor), for: .normal)
        textField.setTextColor(.appColor(.textColor), for: .editing)
        textField.setTextColor(.appColor(.textColor), for: .normal)
        textField.leadingView = nil
    }
}

extension UIView {
    
    func dropShadow(opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.5099999905, green: 0.5099999905, blue: 0.5099999905, alpha: 1)
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    func addConstraintToView(height: CGFloat) {
        let view = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setGradientBackground() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradient.type = .axial
        gradient.colors =  [UIColor(red: 0.055, green: 0.059, blue: 0.067, alpha: 1).cgColor,
                            UIColor(red: 0.275, green: 0.29, blue: 0.302, alpha: 1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.name = "gradient"
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 0.21, tx: 0, ty: 0.29))
        gradient.frame = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
                
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGradientBackgroundTabBarView() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradient.type = .axial
        gradient.colors =  [UIColor(red: 0.231, green: 0.235, blue: 0.239, alpha: 1).cgColor,
                            UIColor(red: 0.376, green: 0.388, blue: 0.4, alpha: 1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.name = "gradient"
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 56.25, tx: 0, ty: -27.5))
        gradient.frame = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
    
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGradientButton() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradient.type = .axial
        gradient.colors =  [UIColor(red: 0, green: 0.467, blue: 1, alpha: 1).cgColor,
                            UIColor(red: 0, green: 0.745, blue: 1, alpha: 1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.name = "gradient"
    
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradientBackground() {
        
        for layer in self.layer.sublayers ?? [] {
            if layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func viewCorner(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.height / 2
        layer.masksToBounds = true
    }
    
    func viewBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    // Simple shadow
    func viewShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    func addTwoShadowsToLineTextField() {
        let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.288, green: 0.031, blue: 0.625, alpha: 0.3).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 2
        layer0.shadowOffset = CGSize(width: 1, height: 1)
        layer0.bounds = self.bounds
        layer0.position = self.center

        self.layer.addSublayer(layer0)

        let shadowPath1 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
        let layer1 = CALayer()
        layer1.shadowPath = shadowPath1.cgPath
        layer1.shadowColor = UIColor.white.cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 2
        layer1.shadowOffset = CGSize(width: -1, height: -1)
        layer1.bounds = self.bounds
        layer1.position = self.center

        self.layer.addSublayer(layer1)
        
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func constrainToEdges(_ subview: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: top)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: bottom)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: leading)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: trailing)
        
        addConstraints([
                        topContraint,
                        bottomConstraint,
                        leadingContraint,
                        trailingContraint])
    }
    
}

extension UITableView {
    
    func create<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
}

extension UICollectionView {
    
    func create<T: UICollectionViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: cell.identifier, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
    }
    
}

extension UITextView {
    
    func hyperLink(originalText: String, hyperLink: [String], urlString: [String], styleAligment: NSTextAlignment) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = styleAligment
        let attributedOriginalText = NSMutableAttributedString(string: originalText, attributes: [ NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.font : UIFont.appFont(familyFont: .beVietnam, name: .regular, size: 14),
            NSAttributedString.Key.foregroundColor : UIColor.appColor(.textColor)])
        
        for i in 0..<hyperLink.count {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLink[i])
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString[i], range: linkRange)
        }
        
        self.linkTextAttributes = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor : UIColor.appColor(.blueApp),
            NSAttributedString.Key.font : UIFont.appFont(familyFont: .beVietnam, name: .semibold, size: 14)]
        
        self.attributedText = attributedOriginalText
    }
    
}

extension Date {
    
    mutating func addDays(n: Int)
    {
        let cal = Calendar.current
        self = cal.date(byAdding: .day, value: n, to: self)!
    }

    func firstDayOfTheMonth() -> Date {
        return Calendar.current.date(from:
            Calendar.current.dateComponents([.year,.month], from: self))!
    }

    func getAllDays() -> [Date]
    {
        var days = [Date]()

        let calendar = Calendar.current

        let range = calendar.range(of: .day, in: .month, for: self)!

        var day = firstDayOfTheMonth()

        for _ in 1...range.count
        {
            days.append(day)
            day.addDays(n: 1)
        }

        return days
    }
}
