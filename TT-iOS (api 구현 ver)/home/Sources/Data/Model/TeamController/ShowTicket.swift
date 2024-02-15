//
//  ShowTicket.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ShowTicket {
    let ticketId: Int
    let workerName: String
    let sequence: Int
    let title: String
    let description: String
    let fileUrlList: [String]
    let status: TicketStatus
    let startTime: Date
    let endTime: Date
    let myTicket: Bool
}
