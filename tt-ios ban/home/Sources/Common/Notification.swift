//
//  Notification.swift
//  home
//
//  Created by 오연서 on 1/24/24.
//

import UIKit

struct Notification {
    let type: NotificationType
    let message: String
    let submessage: String
    let time: String
    let image: UIImage
    let hasViewButton: Bool
}

enum NotificationType: String {
    case feedbackRequest = "feedback" //티켓 피드백 요청
    case ticketReceive = "receive"    //티켓 수신
    case ticketReceiveAgain = "again" //티켓 다시 요청
    case teamInvite = "invite"        //팀 초대
}
