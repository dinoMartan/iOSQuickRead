//
//  APIHandler.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import Foundation
import Alamofire

final class APIHandler {
    
    //MARK: - Public properties
    
    // Singleton
    static let shared = APIHandler()
    
    //MARK: - Private properties
    
    private let alamofire = AF
    private var headers: HTTPHeaders {
        let header = HTTPHeader(name: "Authorization", value: Profile.shared.getToken() ?? "")
        let headers = HTTPHeaders([header])
        return headers
    }
    
    //MARK: - Profile
    
    func registerUser(username: String, email: String, password: String, success: @escaping ((String?) -> Void), failure: @escaping ((Error) -> Void)) {
        
        let parameters = [
            "email": email,
            "username": username,
            "password": password
        ]
        
        alamofire.request(APIConstants.Urls.registerUser, method: .post, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    success(response.response?.headers["Authorization"])
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Articles
    
    func getAllArticles(success: @escaping ((GetArticlesResponse) -> Void), failure: @escaping ((Error) -> Void)) {
        
        alamofire.request(APIConstants.Urls.getAllArticles, method: .get, parameters: APIConstants.Parameters.getAllArticles, headers: headers)
            .responseDecodable(of: GetArticlesResponse.self) { response in
                switch response.result {
                case .success(let articlesResponse):
                    success(articlesResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Sources
    
    func getAllSources(success: @escaping (() -> Void), failure: @escaping ((Error?) -> Void)) {
        
        alamofire.request(APIConstants.Urls.getAllSources, method: .get, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let articlesResponse):
                    //success(articlesResponse)
                    break
                case .failure(let error):
                    break
                    //failure(error)
                }
            }
    }
    
    
}
