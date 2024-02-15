//
//  ShowProjectDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ShowProjectDTO: Decodable {
    let projectId: Int
    let name: String
    let imageUrl: String
}

extension ShowProjectDTO {
    func toDomain() -> ShowProject {
       ShowProject(projectId: projectId, name: name, imageUrl: imageUrl)
    }
}
