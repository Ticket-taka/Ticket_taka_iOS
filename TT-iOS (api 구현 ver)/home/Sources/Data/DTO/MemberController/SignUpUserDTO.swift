//
//  SignUpUser.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct SignUpUserDTO: Encodable {
    let name: String
    let username: String
    let password: String
    let password2: String
    let imageUrl: String
    let deviceToken: String
    let providerType: String
    let email: String
}
