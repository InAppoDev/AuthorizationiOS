//
//  AuthorizationRequests.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation
import Alamofire

class AuthApi: RestClient {
    
    func login(login: String, password: String, resp: @escaping IdResponseBlock) {
        let url = baseUrl + AuthRequests.login
        let params: Parameters = ["login" : login,
                                  "password" : password]
        
        http.queryWithoutTokenBy(url, method: .post, parameters: params, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: AuthResponse.self, resp: resp)
        }
    }
    
    func refresh(resp: @escaping IdResponseBlock) {
        let url = baseUrl + AuthRequests.refresh
        let params: Parameters = ["refresh_token" : UserDefaultsManager().refreshToken ?? ""]
        
        http.queryWithoutTokenBy(url, method: .post, parameters: params, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: AuthResponse.self, resp: resp)
        }
    }
    
    func register(name: String, email: String, phone: String, resp: @escaping IdResponseBlock) {
        let url = baseUrl + AuthRequests.signup
        let params: Parameters = ["name" : name,
                                  "email" : email,
                                  "phone" : phone]
        http.queryWithoutTokenBy(url, method: .post, parameters: params, encoding: JSONEncoding.default, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: SignupResponse.self, resp: resp)
        }
    }
    
    func verifyPhone(id: String, code: String, resp: @escaping IdResponseBlock) {
        let url = baseUrl + AuthRequests.verifyPhone + id
        let params: Parameters = ["code" : code]
        
        http.queryWithoutTokenBy(url, method: .post, parameters: params, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: AuthResponse.self, resp: resp)
        }
    }
    
}
