//
//  TeamProjectDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamSpaceDTO: Decodable {
    let showProjectDtoList: [ShowProjectDTO]
    let memberProfileList: MemberProfileListDTO
}

extension TeamSpaceDTO {
    func toDomain() -> TeamSpace {
        TeamSpace(memberProfiles: memberProfileList.toDomain(),
                  showProjects: showProjectDtoList.map { $0.toDomain() })
    }
}
