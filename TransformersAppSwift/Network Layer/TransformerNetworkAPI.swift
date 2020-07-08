//
//  TransformerNetworkAPI.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 06/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import Foundation
import UIKit

class TransformerNetworkAPI: NSObject {
    var transformerModel: TransformerDataModel?
    var jwtProtectionSpace: URLProtectionSpace?
    
    override init() {
        let url = URL(string : CONSTANT_URL_TOKEN)!
        self.jwtProtectionSpace = URLProtectionSpace(host: url.host!, port: url.port ?? 80, protocol: url.scheme, realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
    }
    
    func getToken(completion: @escaping (ResultType) -> Void) {
        guard let url = URL(string:CONSTANT_URL_TOKEN)
            else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    completion(ResultType.Error(error: error!))
                    return
            }
            do{
                if let jwtString = String(data: dataResponse, encoding: String.Encoding.utf8)
                {
                    let credential = URLCredential(user: "", password: jwtString, persistence: URLCredential.Persistence.permanent)
                    URLCredentialStorage.shared.set(credential, for: self.jwtProtectionSpace!)
                    completion(.Success(result: "Success"))
                }
                
                
            }
            //            catch let parsingError {
            //                completion(ResultType.Error(error: parsingError))
            //            }
        }
        task.resume()
    }
    
    func createTransformer(requestBody:TransformerDataModel, completion: @escaping (ResultType) -> Void) {
        let jwt = retrieveJwt()
        let jwtForHeader = "Bearer "+(jwt as String)
        let request = NSMutableURLRequest(url: URL(string: CONSTANT_URL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(jwtForHeader, forHTTPHeaderField: "Authorization")
        
        let jsonBodyData = try! JSONEncoder().encode(requestBody)
        
        request.httpBody = jsonBodyData
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    completion(ResultType.Error(error: error!))
                    return
            }
            do{
                let decodedCharacterData = try JSONDecoder().decode(TransformerDataModel.self, from: dataResponse)
                completion(.Success(result: decodedCharacterData))
                
            } catch let parsingError {
                completion(ResultType.Error(error: parsingError))
            }
        }
        task.resume()
    }
    
    func getTransformerList(completion: @escaping (ResultType) -> Void) {
        
        let jwt = retrieveJwt()
        let jwtForHeader = "Bearer "+(jwt as String)
        let request = NSMutableURLRequest(url: URL(string: CONSTANT_URL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(jwtForHeader, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    completion(ResultType.Error(error: error!))
                    return
            }
            do{
                let decodedTransformerData = try JSONDecoder().decode(TransformerDataModelArray.self, from: dataResponse)
                completion(.Success(result: decodedTransformerData))
                
            } catch let parsingError {
                completion(ResultType.Error(error: parsingError))
            }
        }
        task.resume()
    }
    
    func updateTransformer(updateRequestBody:TransformerDataModel, completion: @escaping (ResultType) -> Void) {
        let jwt = retrieveJwt()
        let jwtForHeader = "Bearer "+(jwt as String)
        let request = NSMutableURLRequest(url: URL(string: CONSTANT_URL)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(jwtForHeader, forHTTPHeaderField: "Authorization")
        let jsonBodyData = try! JSONEncoder().encode(updateRequestBody)
        request.httpBody = jsonBodyData
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    completion(ResultType.Error(error: error!))
                    return
            }
            do{
                let decodedCharacterData = try JSONDecoder().decode(TransformerDataModel.self, from: dataResponse)
                completion(.Success(result: decodedCharacterData))
                
            } catch let parsingError {
                completion(ResultType.Error(error: parsingError))
            }
        }
        task.resume()
        
    }
    
    func deleteTransformer(transformerId:NSString, completion: @escaping (ResultType) -> Void) {
        let jwt = retrieveJwt()
        let jwtForHeader = "Bearer "+(jwt as String)
        let request = NSMutableURLRequest(url: URL(string: CONSTANT_URL+"/\(transformerId)")!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(jwtForHeader, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let httpResponse = response,
                error == nil else {
                    completion(ResultType.Error(error: error!))
                    return
            }
                if ((httpResponse as! HTTPURLResponse).statusCode == 204) {
                    completion(.Success(result: "Success"))
                }
                else {
                    let error: NSError = NSError(domain: "com.transformers.deletetransformer", code: (httpResponse as! HTTPURLResponse).statusCode, userInfo: ["Error reason": "Unexpected error"])
                   completion(ResultType.Error(error: error))
            }
        }
        task.resume()
    }
    
    func retrieveJwt() -> NSString {
        let credentials = URLCredentialStorage.shared.credentials(for: self.jwtProtectionSpace!)
        return (credentials![""]?.password! as NSString?)!
    }
    
    
}
