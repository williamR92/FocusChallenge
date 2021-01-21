//
//  Login.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/20/21.
//

import Foundation

class LoginResponse: Decodable {
    var dataOk: LoginOk!
    var dataError: LoginErr!
    var code: String!
    
    func LoginResponse(){
        
    }
}

struct LoginOk: Decodable {
    var token: String
}

struct LoginErr: Decodable {
    var error: String
}



