//
//  TicketCreationDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct TicketCreationDTO: Encodable {
    let fileUrlList: [String]
    let title: String
    let description: String
    let workerName: String
    let reviewerNameList: [String]
    let startTime: String
    let endTime: String
    
    init(fileUrlList: [String], 
         title: String,
         description: String,
         workerName: String,
         reviewerNameList: [String],
         startTime: Date,
         endTime: Date) {
        self.fileUrlList = fileUrlList
        self.title = title
        self.description = description
        self.workerName = workerName
        self.reviewerNameList = reviewerNameList
        self.startTime = startTime.toString()
        self.endTime = endTime.toString()
    }
}
