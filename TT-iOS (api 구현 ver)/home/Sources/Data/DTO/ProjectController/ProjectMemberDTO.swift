//
//  ProjectMemberDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ProjectMemberDTO: Decodable {
    let profileDto: ShowMemberProfileDTO
    let totalTicket: Int
    let doneTicket: Int
    let achiveLevel: Int
}

extension ProjectMemberDTO {
    func toDomain() -> ProjectMember {
        ProjectMember(profile: profileDto.toDomain(),
                      totalTicket: totalTicket,
                      doneTicket: doneTicket,
                      achiveLevel: achiveLevel)
    }
}
