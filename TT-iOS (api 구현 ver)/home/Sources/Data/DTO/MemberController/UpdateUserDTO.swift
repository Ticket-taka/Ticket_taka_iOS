//
//  UpdateUserDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct UpdateUserInformationDTO: Encodable {
    let name: String
    let username: String
    let password: String
}

struct UpdateUserDTO: Encodable {
    let image: String?
    let request: UpdateUserInformationDTO
}
