//
//  TeamCalendarTicketDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TeamCalendarTicketDTO: Decodable {
    let ticketId: Int
    let ticketHex: String
    let startTime: String
    let endTime: String
}

extension TeamCalendarTicketDTO {
    func toDomain() -> TeamCalendarTicket {
        TeamCalendarTicket(ticketId: ticketId, 
                           ticketHex: ticketHex,
                           startTime: startTime.toDate() ?? Date(),
                           endTime: endTime.toDate() ?? Date())
    }
}
