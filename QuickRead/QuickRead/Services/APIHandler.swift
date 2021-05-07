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
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    success(response.response?.headers["Authorization"])
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func forgotPassword(email: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        
        let parameters = [ "email": email ]
        
        alamofire.request(APIConstants.Urls.forgotPassword, method: .post, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func validateResetToken(token: String, success: @escaping ((String?) -> Void), failure: @escaping ((Error) -> Void)) {
        
        let parameters = [ "token": token ]
        
        alamofire.request(APIConstants.Urls.validateResetToken, method: .post, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success(_):
                    success(response.response?.headers["Authorization"])
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func changePassword(password: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        let parameters = [
            "newPassword": password,
            "confirmPassword": password
        ]
    
        alamofire.request(APIConstants.Urls.changePassword, method: .put, parameters: parameters, headers: self.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Articles
    
    func getAllArticles(success: @escaping ((GetArticlesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken {
            self.alamofire.request(APIConstants.Urls.getAllArticles, method: .get, parameters: APIConstants.Parameters.getAllArticles, headers: self.headers)
                .responseDecodable(of: GetArticlesResponse.self) { response in
                    switch response.result {
                    case .success(let articlesResponse):
                        success(articlesResponse)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: {
            failure(nil)
        }
    }
    
    func getArticlesForCategory(page: Int, category: String, success: @escaping ((GetArticlesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken {
            let parameters: [String: Any] = [
                "category": category,
                "items": 20,
                "page": page
            ]
            
            self.alamofire.request(APIConstants.Urls.getArticlesForCategory, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.headers)
                .responseDecodable(of: GetArticlesResponse.self) { response in
                    switch response.result {
                    case .success(let articlesResponse):
                        success(articlesResponse)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: {
            failure(nil)
        }
    }
    
    func getArticlesForSourceCategory(page: Int, source: String, category: String, success: @escaping ((GetArticlesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken {
            let parameters: [String: Any] = [
                "page": page,
                "category": category,
                "idSource": source,
                "items": 10
            ]
            
            self.alamofire.request(APIConstants.Urls.getArticlesForSourceCategory, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.headers)
                .responseDecodable(of: GetArticlesResponse.self) { response in
                    switch response.result {
                    case .success(let articlesResponse):
                        success(articlesResponse)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: {
            failure(nil)
        }
    }
    
    //MARK: - Sources
    
    func getAllSources(success: @escaping ((SourcesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken {
            self.alamofire.request(APIConstants.Urls.getAllSources, method: .get, headers: self.headers)
                .responseDecodable(of: SourcesResponse.self) { response in
                    switch response.result {
                    case .success(let sourcesResponse):
                        success(sourcesResponse)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: {
            failure(nil)
        }
    }
    
    //MARK: - Categories
    
    func getAllCategories(success: @escaping ((CategoriesResponse) -> Void), failure: @escaping ((Error?) -> Void)) {
        checkToken {
            self.alamofire.request(APIConstants.Urls.getAllCategories, method: .get, headers: self.headers)
                .responseDecodable(of: CategoriesResponse.self) { response in
                    switch response.result {
                    case .success(let categoriesResponse):
                        success(categoriesResponse)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: {
            failure(nil)
        }

    }
    
    //MARK: - Token validation -
    
    private func checkToken(success: @escaping (() -> Void), failure: @escaping(() -> Void)) {
        if Profile.shared.tokenDidExpire() {
            Profile.shared.silentLogin {
                success()
            } failure: { _ in
                failure()
            }
        }
        else {
            success()
        }
    }
    
}
