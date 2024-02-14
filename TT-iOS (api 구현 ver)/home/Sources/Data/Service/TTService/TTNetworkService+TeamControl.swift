//
//  NetworkService+TeamControl.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

// MARK: - Team Controller
extension TTNetworkService {
    /// 생성된 팀 목록, 초대 팀 목록 조회
    /// - Returns: Team Invitation
    func fetchTeams() -> Observable<TeamInvitation> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamInvitationDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// Team 생성 API
    /// - Parameters:
    ///   - image: 팀 이미지
    ///   - teamName: 팀 이름
    ///   - invitedUsernameList: 초대 유저 이름 목록
    /// - Returns: Team
    func createTeam(image: UIImage,
                    teamName: String,
                    invitedUsernameList: [String]) -> Observable<Team> {
        let teamInvitationDTO = TeamCreationDTO(image: image.toPngString(),
                                                request: TeamCreationInformationDTO(teamName: teamName,
                                                                                    invitedUsernameList: invitedUsernameList))
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams",
                                            httpBodyObject: teamInvitationDTO) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 팀 멤버 초대
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - invitedUsernameList: 초대 유저 이름 목록
    /// - Returns: Team
    func inviteTeamUser(teamId:Int,
                        invitedUsernameList: [String]) -> Observable<Team> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams/\(teamId)",
                                            httpBody: ["invitedUsernameList": invitedUsernameList]) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 팀 삭제
    /// - Parameter teamId: 팀 ID
    /// - Returns: Team Invitation
    func removeTeam(teamId:Int) -> Observable<TeamInvitation> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .delete,
                                            path: "teams/\(teamId)") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamInvitationDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 팀 멤버 초대 수락/거절
    /// - Parameters:
    ///   - invitationTeamId: 팀 ID
    ///   - accept: 수락 / 거절
    /// - Returns: Team Invitation
    func responseTeamInvitation(invitationTeamId: Int,
                                accept: Bool) -> Observable<TeamInvitation> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams/invitation-response",
                                            httpBody: ["invitationId": invitationTeamId,
                                                       "accept": accept]) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamInvitationDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    // FIXME: - update
    /// 팀 정보 수정 API
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - image: 변경할 팀 이미지
    /// - Returns: Team
    func updateTeamInformation(teamId: Int,
                               image: UIImage) -> Observable<Team> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .patch,
                                            path: "teams/\(teamId)/update") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 팀 색상 수정 API
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - color: 변경할 팀 색상
    /// - Returns: Team
    func updateTeamColor(teamId: Int,
                         color: String) -> Observable<Team> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .patch,
                                            path: "teams/\(teamId)/color") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 팀 캘린더 조회
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - status: ticket 상태 (todo / inprogress / done)
    ///   - sort: 정렬 (마감순 - asc, desc)
    ///   - memberId: 멤버 ID
    /// - Returns: Team Calendar
    func fetchTeamCalendar(teamId: Int,
                           status: TicketStatus?,
                           sort: Sort?,
                           memberId: String?) -> Observable<TeamCalendar> {
        let query = ["status": status?.rawValue.lowercased(),
                     "sort": sort?.rawValue.lowercased(),
                     "memberId": memberId].compactMapValues { $0 }
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/calendar",
                                            query: query) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamCalendarDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
}
