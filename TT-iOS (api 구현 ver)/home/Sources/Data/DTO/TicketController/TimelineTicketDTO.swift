//
//  TimelineTicketDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TimelineTicketDTO: Decodable {
    let timelineName: String
    let ticketDtoList: [ShowTicketDTO]
    let memberProfileListDto: MemberProfileListDTO
}

extension TimelineTicketDTO {
    func toDomain() -> TimelineTicket {
        TimelineTicket(timelineName: timelineName,
                       tickets: ticketDtoList.map{ $0.toDomain() },
                       memberProfiles: memberProfileListDto.toDomain())
    }
}

