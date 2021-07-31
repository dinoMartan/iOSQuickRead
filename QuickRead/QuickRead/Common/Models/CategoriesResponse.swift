//
//  CategoriesResponse.swift
//  QuickRead
//
//  Created by Dino Martan on 27/04/2021.
//

import Foundation

struct CategoriesResponse: Codable {
    
    let categories: [String]
    
    enum CodingKeys: String, CodingKey {
        
        case categories = "categoryList"
        
    }
    
}
