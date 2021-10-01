//
//  LoginEnums.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 30.11.2020.
//

import UIKit

enum SignUpItems: Int, CaseIterable {
    case fullName
    case email
    case password
    case phone
    
    var title: String {
        switch self {
        case .fullName: return "Full Name"
        case .email: return "E-mail"
        case .password: return "Password"
        case .phone: return "Phone Number"
        }
    }
    
    var isPasword: Bool {
        switch self {
        case .password: return true
        case .fullName, .email, .phone: return false
        }
    }
    
    var contentType: UITextContentType? {
        switch self {
        case .fullName: return .name
        case .email: return .emailAddress
        case .password: return .password
        case .phone: return .telephoneNumber
        }
    }
    
    var keybordType: UIKeyboardType {
        switch self {
        case .fullName, .password: return .default
        case .email: return .emailAddress
        case .phone: return .phonePad
        }
    }
    
}

enum SignInItems: Int, CaseIterable {
    case email
    case password
    
    var title: String {
        switch self {
        case .email: return "E-mail"
        case .password: return "Password"
        }
    }
    
    var isPasword: Bool {
        switch self {
        case .password: return true
        case .email: return false
        }
    }
    
    var contentType: UITextContentType? {
        switch self {
        case .email: return .emailAddress
        case .password: return .password
        }
    }
    
    var keybordType: UIKeyboardType {
        switch self {
        case .password: return .default
        case .email: return .emailAddress
        }
    }
    
}
