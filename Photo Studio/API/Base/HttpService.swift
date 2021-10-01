//
//  HttpService.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation
import Alamofire

typealias IdResponseBlock = (_ swiftObj: Any?, _ error: Error?) -> Void

enum QueueQos {
    case background
    case defaultQos
}

protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    
    var localizedDescription: String
    var code: Int
    
    init(localizedDescription: String, code: Int) {
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class HttpService {
    
    private let userDefaults = UserDefaultsManager()
    
    func checkInternetConnect() -> Bool {
        return InternetService.shared.checkInternetConnect()
    }
    
    func internetConnectErr() -> CustomError {
        return CustomError(localizedDescription: StringValue.Base.noInternetConnection, code: 404)
    }
    
    func serverError() -> CustomError {
        return CustomError(localizedDescription: "Could not access the server", code: 500)
    }
    
    func serverSomthWrongError() -> CustomError {
        return CustomError(localizedDescription: StringValue.Base.oopsTryAgainLater, code: 404)
    }
    
    func requestError(_ description: String?, _ error: Int?) -> CustomError {
        return CustomError(localizedDescription: description ?? StringValue.Base.oopsTryAgainLater, code: error ?? 404)
    }
    
}

extension HttpService {
    
    func cancellAllRequests() {
        
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
    func queryBy(_ url: URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 queue: QueueQos,
                 headers: HTTPHeaders? = nil,
                 resp: @escaping IdResponseBlock) {
        
        guard let tokenValue = userDefaults.token else { return }
        
        let token = tokenValue
        var headersForQuery: HTTPHeaders = headers ?? [Keys.autorithationToken: token]
        headersForQuery[Keys.autorithationToken] = token
        
        return query(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headersForQuery,
                     queue: queue,
                     resp: resp)
    }
    
    func queryWithoutTokenBy(_ url: URLConvertible,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: HTTPHeaders? = nil,
                             queue: QueueQos,
                             resp: @escaping IdResponseBlock) {
        
        query(url,
              method: method,
              parameters: parameters,
              encoding: encoding,
              headers: headers,
              queue: queue,
              resp: resp)
        
    }
    
    func query(_ url: URLConvertible,
               method: HTTPMethod = .get,
               parameters: Parameters? = nil,
               encoding: ParameterEncoding = URLEncoding.default,
               headers: HTTPHeaders? = nil,
               queue: QueueQos,
               resp: @escaping IdResponseBlock) {
        
        let queueQos: DispatchQueue
        
        switch queue {
        case QueueQos.defaultQos:
            queueQos = DispatchQueue(label: "com.queueDefault", qos: .default, attributes: [.concurrent])
        case QueueQos.background:
            queueQos = DispatchQueue(label: "com.queueBackground", qos: .background, attributes: [.concurrent])
        }
        
        if !checkInternetConnect() {
            return resp(nil, internetConnectErr())
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let request = AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers
        ).validate().responseData(queue: queueQos) { (response) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let statusCode = response.response?.statusCode else {
                print("ERROR: Not Found status code")
                return resp(nil, CustomError(localizedDescription: "Not Found status code", code: 0))
            }
            
            switch response.result {
            case .success(let value):
                return resp(value, nil)
            case .failure(let error):
//                return resp(nil, self.parseError(response.data, statusCode: statusCode))
                return resp(nil, CustomError(localizedDescription: "Error", code: statusCode))
            }
        }
    }
    
    func queryMultipart(_ url: URLConvertible,
                        method: HTTPMethod = .post,
                        parameters: Parameters? = nil,
                        data: [String : Data]? = nil,
                        fileName: String? = nil,
                        image: [UIImage]? = nil,
                        keyForFile: String = "avatar",
                        headers: HTTPHeaders? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        resp: @escaping IdResponseBlock) {
        
        if !checkInternetConnect() {
            return resp(nil, internetConnectErr())
        }
        
        guard let tokenValue = userDefaults.token else { return }
        
        let token = tokenValue
        var headersForQuery: HTTPHeaders = headers ?? [Keys.autorithationToken: token]
        headersForQuery[Keys.autorithationToken] = token
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            if let params = parameters {
                for (key, value) in params {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            
            if let data = data {
                for (key, value) in data {
                    print(value.description)
                    multipartFormData.append(value, withName: key, fileName: key + ".wav", mimeType: "wav")
                }
            }
            
            if let data = image {
                
                for item in data {
                    
                    guard let fName = fileName else { return }
                    
                    if let imageData = item.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: keyForFile, fileName: fName, mimeType: "image/jpeg")
                    }
                }
            }
            
        }, to: url, method: method, headers: headersForQuery).validate().responseData { (response) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let statusCode = response.response?.statusCode else {
                print("ERROR: Not Found status code")
                return resp(nil, CustomError(localizedDescription: "Not Found status code", code: 0))
            }
            
            switch response.result {
            case .success(let value):
                return resp(value, nil)
            case .failure(let error):
                print(error)
                resp(nil, self.serverError())
            }
        }
        
    }
    
//    private func parseError(_ data: Data?, statusCode: Int) -> CustomError {
//        guard let data = data else { return serverError() }
//
//        do {
//            let model = try JSONDecoder().decode(ErrorRequest.self, from: data)
//            print(model.error)
//            switch model.error {
//            case "No such user":
//                return CustomError(localizedDescription: StringValue.Authorization.errorEnterDate, code: statusCode)
//            case "Passwords dont match":
//                return CustomError(localizedDescription: StringValue.Authorization.errorEnterDate.localized, code: statusCode)
//            default:
//                return CustomError(localizedDescription: model.error, code: statusCode)
//            }
//        } catch let error {
//            print(error)
//            return serverError()
//        }
//    }
}
