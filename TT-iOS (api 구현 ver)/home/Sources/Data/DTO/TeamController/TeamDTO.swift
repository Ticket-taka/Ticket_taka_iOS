//
//  TeamDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamDTO: Decodable {
    let teamId: Int
    let teamName: String
    let imageUrl: String
}

extension TeamDTO {
    func toDomain() -> Team {
        Team(teamId: teamId,
             teamName: teamName,
             imageUrl: imageUrl)
    }
}
