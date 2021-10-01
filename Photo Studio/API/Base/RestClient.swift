//
//  RestClient.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation
import Alamofire

class RestClient: NSObject {
    
    let http = HttpService()
    let baseUrl = BaseRequests.baseURL
    
    let dataIsNil = CustomError.init(localizedDescription: "Error parsing", code: 0)
    
    func response<P: Codable>(_ response: Any?, _ error: Error?, modelCls: P.Type, key: String? = nil, resp: @escaping IdResponseBlock) {
        
        if let error = error {
            return resp(nil, error)
        }
        
        guard let data = response as? Data else {
            return resp(nil, error)
        }
        
        do {
            let model = try JSONDecoder().decode(modelCls.self, from: data)
            return resp(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch {
            print("error: ", error)
            return resp(nil, self.dataIsNil)
        }
    }
    
    func cancellRequests() {
        http.cancellAllRequests()
    }
}
