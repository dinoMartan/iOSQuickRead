//
//  Profile.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import Foundation

final class Profile {
    
    //MARK: - Public properties
    
    static var shared = Profile()
    
    //MARK: - Private properties
    
    private let defaults = UserDefaults.standard
    
    private var token: String? {
        guard let token = defaults.string(forKey: "token") else { return nil }
        return token
    }
    
    //MARK: - Public methods
    
    func setToken(token: String) {
        defaults.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        return token
    }
    
}
