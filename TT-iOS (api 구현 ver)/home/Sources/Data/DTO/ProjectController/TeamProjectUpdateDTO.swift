//
//  TeamProjectUpdate.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamProjectUpdateInformationDTO: Encodable {
    let name: String
    let description: String
}

struct TeamProjectUpdateDTO: Encodable {
    let image: String?
    let request: TeamProjectUpdateInformationDTO
}
