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
    
    private var expirationDate: Date? {
        guard let expirationDate = defaults.object(forKey: "expirationDate") as? Date else { return nil }
        return expirationDate
    }
    
    //MARK: - Public methods
    
    func setToken(token: String) {
        defaults.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        return token
    }
    
    func getExpirationDate() -> Date? {
        return expirationDate
    }
    
    func setExpirationDate(expirationDate: Date) {
        defaults.set(expirationDate, forKey: "expirationDate")
    }
    
    func tokenDidExpire() -> Bool {
        guard let expirationDate = expirationDate else { return true }
        if expirationDate <= Date() { return true }
        else { return false }
    }
    
    func saveLoginData(username: String, password: String) {
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
    }
    
    func silentLogin(success: @escaping (() -> Void), failure: @escaping ((Error?) -> Void)) {
        guard let username = defaults.string(forKey: "username"), let password = defaults.string(forKey: "password") else {
            failure(nil)
            return
        }
        APIHandler.shared.loginUser(username: username, password: password) { token in
            if token != nil {
                self.setToken(token: token!)
                self.setExpirationDate(expirationDate: Date().addingTimeInterval(3500))
                success()
            }
        } failure: { error in
            failure(error)
        }
    }
    
    func logout() -> Bool {
        guard let domain = Bundle.main.bundleIdentifier else { return false }
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        return true
    }
    
}
