//
//  TTNetworkService+ProjectControl.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

// MARK: - Project Controller
extension TTNetworkService {
    /// 팀 공간 창 - 참여 팀원, 모든 project 표시
    /// - Parameters:
    ///   - teamId: 팀 ID
    /// - Returns: Team Space
    func fetchTeamProjects(teamId: Int) -> Observable<TeamSpace> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamSpaceDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// Project 생성
    /// - Parameters:
    ///   - teamId: 팀 ID
    /// - Returns: 생성된 ProjectId
    func createTeamProject(teamId: Int) ->  Observable<Int> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams/\(teamId)/projects") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: ProjectCreationResultDTO.self)
        .map { $0.projectId }
        .asObservable()
    }
    
    /// 팀 프로젝트 삭제
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    /// - Returns: Team Space
    func removeTeamProject(teamId: Int, 
                           projectId: Int) ->  Observable<TeamSpace> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .delete,
                                            path: "teams/\(teamId)/projects") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamSpaceDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 각 project 상세창
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    /// - Returns: Team Project Detail
    func fetchTeamProjectDetail(teamId: Int,
                                projectId: Int) ->  Observable<TeamProjectDetail> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects/\(projectId)") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TeamProjectDetailDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// project 정보 수정 요청
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    /// - Returns: Team Project 
    func updateTeamProjectDetail(teamId: Int,
                                projectId: Int,
                                 image: UIImage,
                                 name: String,
                                 description: String) ->  Observable<ShowProject> {
        let teamProjectUpdateDto = TeamProjectUpdateDTO(image: image.toPngString(),
                                                        request: .init(name: name,
                                                                       description: description))
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects/\(projectId)",
        httpBodyObject: teamProjectUpdateDto) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: ShowProjectDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
}
