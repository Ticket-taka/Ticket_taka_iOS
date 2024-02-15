//
//  TeamCalendarDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamCalendarDTO: Decodable {
    let teamName: String
    let teamCalendarTicketDtoList: [TeamCalendarTicketDTO]
    let showTicketDtoList: [ShowTicketDTO]
    let memberProfileListDto: MemberProfileListDTO
}

extension TeamCalendarDTO {
    func toDomain() -> TeamCalendar {
        TeamCalendar(teamName: teamName,
                     teamCalendarTickets: teamCalendarTicketDtoList.map { $0.toDomain() },
                     showTickets: showTicketDtoList.map { $0.toDomain() },
                     memberProfiles: memberProfileListDto.toDomain())
    }
}
