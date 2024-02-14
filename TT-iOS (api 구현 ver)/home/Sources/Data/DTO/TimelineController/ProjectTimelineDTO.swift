//
//  ProjectTimelineDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ProjectTimelineDTO: Decodable {
    let projectName: String
    let showTimelineDtoList: [ShowTimelineDTO]
}

extension ProjectTimelineDTO {
    func toDomain() -> ProjectTimeline {
        ProjectTimeline(projectName: projectName,
                        showTimelines: showTimelineDtoList.map{ $0.toDomain() })
    }
}

