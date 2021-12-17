//
//  UserService.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

final class UserService {
    var isUserAuth: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isUserAuth")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isUserAuth")
        }
    }
}
