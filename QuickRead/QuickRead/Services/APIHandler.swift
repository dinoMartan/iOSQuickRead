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
    
    static let shared = APIHandler()
    
    //MARK: - Private properties
    
    private let alamofire = AF
    private var headers: HTTPHeaders {
        let header = HTTPHeader(name: "Authorization", value: Profile.shared.getToken() ?? "")
        let headers = HTTPHeaders([header])
        return headers
    }
    
    //MARK: - API calls -
    
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
    
    func loginUser(username: String, password: String, success: @escaping ((String?) -> Void), failure: @escaping ((Error) -> Void)) {
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        alamofire.request(APIConstants.Urls.loginUser, method: .post, parameters: parameters)
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
        checkToken()
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
    
    func getArticlesForCategory(category: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        checkToken()
        
        let parameters: [String: String] = ["category": category]
        
        alamofire.request(APIConstants.Urls.getArticlesForCategory, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let articlesResponse):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Sources
    
    func getAllSources(success: @escaping ((SourcesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken()
        alamofire.request(APIConstants.Urls.getAllSources, method: .get, headers: headers)
            .responseDecodable(of: SourcesResponse.self) { response in
                switch response.result {
                case .success(let sourcesResponse):
                    success(sourcesResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Categories
    
    func getAllCategories(success: @escaping ((CategoriesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken()
        alamofire.request(APIConstants.Urls.getAllCategories, method: .get, headers: headers)
            .responseDecodable(of: CategoriesResponse.self) { response in
                switch response.result {
                case .success(let categoriesResponse):
                    success(categoriesResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Token validation -
    
    private func checkToken() {
        if Profile.shared.tokenDidExpire() {
            Profile.shared.silentLogin {
                //
            } failure: { _ in
                //
            }

        }
    }
    
}
