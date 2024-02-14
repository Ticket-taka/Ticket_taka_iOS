//
//  SignInUser.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct SignInUserDTO: Encodable {
    let username: String
    let password: String
    let keepStatus: Bool
}
