//
//  UserDefaultsManager.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation

class UserDefaultsManager {
    
    private var currentDefaults: UserDefaults = .standard
    
    private func getFromLocalStorage<T: Codable>(model: T.Type, key: String) -> T? {
        
        if let decoded = currentDefaults.object(forKey: key) as? String {
            
            guard let data = decoded.data(using: .utf8) else { return nil }
            
            if let product = try? JSONDecoder().decode(model.self, from: data) {
                return product
            }
        }
        
        return nil
    }
    
    private func saveToLocalStorage(key: String, encodedData: String) {
        currentDefaults.set(encodedData, forKey: key)
    }
    
    private func removeObject(key: String) {
        currentDefaults.removeObject(forKey: key)
    }
    
    var token: String? {
        
        get {
            return currentDefaults.object(forKey: Keys.autorithationToken) as? String
        }
        
        set {
            currentDefaults.set(newValue, forKey: Keys.autorithationToken)
        }
    }
    
    var refreshToken: String? {
        
        get {
            return currentDefaults.object(forKey: Keys.refreshToken) as? String
        }
        
        set {
            currentDefaults.set(newValue, forKey: Keys.refreshToken)
        }
    }
    
}
