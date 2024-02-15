//
//  TTNetworkService+TicketController.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

// MARK: - Ticket Controller
extension TTNetworkService {
    /// Timeline 별 Ticket 조회
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - status: ticket 상태 (todo / inprogress / done)
    /// - Returns: Project Timeline
    func fetchTimelineTickets(teamId: Int,
                              projectId: Int,
                              timelineId: Int,
                              status: TicketStatus) -> Observable<TimelineTicket> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines/\(timelineId)",
                                            query: ["status": status.rawValue.lowercased()]) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TimelineTicketDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// Ticket 생성 요청
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - timelineId: 타임라인 ID
    ///   - fileUrlList: file URL 목록
    ///   - title: 제목
    ///   - description: 설명
    ///   - workerName: workerName
    ///   - reviewerNameList: reviewer 이름 목록
    ///   - startTime: 시작 시간
    ///   - endTime: 종료 시간
    /// - Returns: 티켓 ID
    func createTimelineTickets(teamId: Int,
                               projectId: Int,
                               timelineId: Int,
                               fileUrlList: [String],
                               title: String,
                               description: String,
                               workerName: String,
                               reviewerNameList: [String],
                               startTime: Date,
                               endTime: Date) -> Observable<Int> {
        
        let ticketCreationDto = TicketCreationDTO(fileUrlList: fileUrlList,
                                                  title: title,
                                                  description: description,
                                                  workerName: workerName,
                                                  reviewerNameList: reviewerNameList,
                                                  startTime: startTime,
                                                  endTime: endTime)
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines/\(timelineId)",
        httpBodyObject: ticketCreationDto) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TicketCreationResultDTO.self)
        .map { $0.id }
        .asObservable()
    }
    
    /// Ticket 삭제 요청
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - timelineId: 타임라인 ID
    ///   - ticketId: 삭제할 티켓 ID
    /// - Returns: 삭제된 티켓
    func removeTimelineTickets(teamId: Int,
                               projectId: Int,
                               timelineId: Int,
                               ticketId: Int) -> Observable<ShowTicket> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .delete,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines/\(timelineId)",
                                            httpBody: ["ticketId": ticketId]) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: ShowTicketDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// Ticket 생성창 조회
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - timelineId: 타임라인 ID
    /// - Returns: 티켓 생성시 참여 가능한 Member 목록
    func fetchTimelineMembers(teamId: Int,
                               projectId: Int,
                               timelineId: Int) -> Observable<[ShowMemberProfile]> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines/\(timelineId)/member-info") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: MemberProfileListDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
}
