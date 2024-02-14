//
//  ShowTicketDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ShowTicketDTO: Decodable {
    let ticketId: Int
    let workerName: String
    let sequence: Int
    let title: String
    let description: String
    let fileUrlList: [String]
    let status: String
    let startTime: String
    let endTime: String
    let myTicket: Bool
}

extension ShowTicketDTO {
    func toDomain() -> ShowTicket {
        ShowTicket(ticketId: ticketId,
                   workerName: workerName,
                   sequence: sequence,
                   title: title,
                   description: description,
                   fileUrlList: fileUrlList,
                   status: TicketStatus(rawValue: status) ?? .done,
                   startTime: startTime.toDate() ?? Date(),
                   endTime: endTime.toDate() ?? Date(),
                   myTicket: myTicket)
    }
}
