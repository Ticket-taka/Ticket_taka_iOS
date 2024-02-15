//
//  TeamInvitationDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamInvitationDTO: Decodable {
    let teamDtoList: [TeamDTO]
    let invitationDtoList: [InvitationDTO]
}

extension TeamInvitationDTO {
    func toDomain() -> TeamInvitation {
        TeamInvitation(teamList: teamDtoList.map { $0.toDomain() },
                       invitationList:  invitationDtoList.map { $0.toDomain() })
    }
}
