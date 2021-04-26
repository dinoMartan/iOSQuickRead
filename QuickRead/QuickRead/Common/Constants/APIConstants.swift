//
//  APIConstants.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import Foundation

private let endpoint = "http://3.23.98.160:8050"
private let userEndpoint = "http://3.23.98.160:8020"

enum APIConstants {
    
    struct Urls {
        
        static let getAllArticles = endpoint + "/getAllArticles"
        static let getAllSources = endpoint + "/getAllSources"
        static let registerUser = userEndpoint + "/signUp"
        
    }
    
    struct Parameters {
        
        static let getAllArticles = ["items": 20]
        
    }
    
}
