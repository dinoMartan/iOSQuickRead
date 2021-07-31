//
//  GetArticlesResponse.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import Foundation

// MARK: - GetArticlesResponse

struct GetArticlesResponse: Codable {
    
    let articles: [Article]
    
}

// MARK: - Article

struct Article: Codable {
    
    let categories: [String]
    let idURL: String
    let idSource: String
    let title: String
    let imageURL: String
    let author: String?
    let publishDate: String?
    let summary: String

    enum CodingKeys: String, CodingKey {
        
        case categories = "category"
        case idURL = "idUrl"
        case idSource
        case title
        case imageURL = "imageUrl"
        case author
        case publishDate
        case summary
        
    }
}
