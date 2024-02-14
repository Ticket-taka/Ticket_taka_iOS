//
//  InvitationDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct InvitationDTO: Decodable {
    let id: Int
    let teamDTO: TeamDTO
}

extension InvitationDTO {
    func toDomain() -> Invitation {
        Invitation(id: id, team: teamDTO.toDomain() )
    }
}
