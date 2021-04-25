//
//  APIConstants.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import Foundation

private let endpoint = "http://3.23.98.160:8050"

enum APIConstants {
    
    struct Urls {
        
        static let getAllArticles = endpoint + "/getAllArticles"
        static let getAllSources = endpoint + "/getAllSources"
        
    }
    
    struct Parameters {
        
        static let getAllArticles = ["items": 1]
        
    }
    
}
