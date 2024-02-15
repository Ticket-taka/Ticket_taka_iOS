//
//  ShowTimelineDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ShowTimelineDTO: Decodable {
    let timelineId: Int
    let name: String
    let imageUrl: String
}

extension ShowTimelineDTO {
    func toDomain() -> ShowTimeline {
        ShowTimeline(timelineId: timelineId, name: name, imageUrl: imageUrl)
    }
}
