//
//  TeamProjectDetailDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamProjectDetailDTO: Decodable {
    let teamName: String
    let projectName: String
    let memberListDTO: [ProjectMemberDTO]
    let projectDescription: String
    let linkList: [String]
}

extension TeamProjectDetailDTO {
    func toDomain() -> TeamProjectDetail {
        TeamProjectDetail(teamName: teamName,
                          projectName: projectName,
                          members: memberListDTO.map { $0.toDomain() },
                          projectDescription: projectDescription,
                          linkList: linkList)
    }
}
