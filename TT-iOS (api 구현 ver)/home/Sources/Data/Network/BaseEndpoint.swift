//
//  BaseEndpoint.swift
//  home
//
//  Created by 오연서 on 2/13/24.
//

import Foundation

enum BaseEndpoint {
    case member(_ memberId: String? = nil)
    case teams(_ teamId: String? = nil)
    case project(teamId: String, _ projectId: String? = nil)
    case timeline(teamId: String, projectId: String)
    case ticket(teamId: String, projectId: String, _ timelineId: String)
    case community
    case calendar
    case alarm
    
    func subPath(with appendedPath: String) -> String {
        var subPathList: [String?] = []
        switch self {
        case let .member(memberId):
            subPathList = ["members", memberId]
        case let .teams(teamId):
            subPathList = ["teams", teamId]
        case let .project(teamId, projectId):
            subPathList = ["teams", teamId, 
                           "projects", projectId]
        case let .timeline(teamId, projectId):
            subPathList = ["teams", teamId, 
                           "projects", projectId,
                           "timelines"]
        case let .ticket(teamId, projectId, timelineId):
            subPathList = ["teams", teamId,
                           "projects", projectId,
                           "timelines", timelineId]
        default: break
        }
        return (subPathList
            .compactMap{ $0 } + [appendedPath])
            .joined(separator: "/")
    }

    var requestURL: String {
        switch self {
        case.teams: return URL.makeEndPointString("/teams")
        case.project: return URL.makeEndPointString("/teams/{teamId}/projects")
        case.timeline: return URL.makeEndPointString("/teams/{teamId}/projects/{projectId}/timelines")
        case.ticket: return URL.makeEndPointString("/teams/{teamId}/projects/{projectId}/timelines")
        case.community: return URL.makeEndPointString("/community")
        case.calendar: return URL.makeEndPointString("/calendar")
        case.alarm: return URL.makeEndPointString("/alarms")
        case.member: return URL.makeEndPointString("/members")
        }
    }
}
