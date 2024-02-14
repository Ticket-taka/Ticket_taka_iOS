//
//  TimelineCreationDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TimelineCreationInformationDTO: Encodable {
    let name: String
}

struct TimelineCreationDTO: Encodable {
    let image: String?
    let request: TimelineCreationInformationDTO
}
