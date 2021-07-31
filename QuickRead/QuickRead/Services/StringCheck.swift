//
//  StringCheck.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import Foundation

final class StringCheck {
    
    static func checkStrings(strings: [String]) -> Bool {
        for string in strings {
            if string.isEmpty { return false }
        }
        return true
    }

}
