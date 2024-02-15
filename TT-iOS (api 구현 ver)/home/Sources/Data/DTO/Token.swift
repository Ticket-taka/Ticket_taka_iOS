//
//  Token.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct Token: Codable {
    let grantType: String
    let accessToken: String
    let refreshToken: String
}
