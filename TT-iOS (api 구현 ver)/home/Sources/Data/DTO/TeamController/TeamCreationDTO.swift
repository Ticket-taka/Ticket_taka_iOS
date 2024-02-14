//
//  TeamCreationDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamCreationInformationDTO: Encodable {
    let teamName: String
    let invitedUsernameList: [String]
}

struct TeamCreationDTO: Encodable {
    let image: String?
    let request: TeamCreationInformationDTO
}
