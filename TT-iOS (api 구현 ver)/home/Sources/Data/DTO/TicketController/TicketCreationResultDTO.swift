//
//  TicketCreationResultDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TicketCreationResultDTO: Decodable {
    let id: Int
    let sequence: Int
    let createdTime: String
}
