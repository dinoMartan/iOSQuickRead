//
//  Sources.swift
//  QuickRead
//
//  Created by Dino Martan on 27/04/2021.
//

import Foundation

final class Sources {
    
    //MARK: - Public properties
    
    static let shared = Sources()
    
    //MARK: - Private properties
    
    private var sources: [String] = []
    
    //MARK: - Public methods
    
    func getSources() -> [String] {
        return sources
    }
    
    func setSources(sources: [String]) {
        self.sources = sources
    }
    
}
