//
//  TTNetworkService+TicketController.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

// MARK: - Timeline Controller
extension TTNetworkService {
    /// 모든 타임라인 조회
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    /// - Returns: Project Timeline
    func fetchEntireTimelines(teamId: Int, projectId: Int) -> Observable<ProjectTimeline> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: ProjectTimelineDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    /// 타임라인 생성
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - image: 타임라인 이미지
    ///   - name: 타임라인 이름
    /// - Returns: Project ID
    func createTimeline(teamId: Int,
                        projectId: Int,
                        image: UIImage,
                        name: String) -> Observable<Int> {
        let timelineCreationDto = TimelineCreationDTO(image: image.toPngString(),
                                                      request: .init(name: name))
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .post,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: TimelineCreationResultDTO.self)
        .map { $0.projectId }
        .asObservable()
    }
    
    /// 타임라인 삭제
    /// - Parameters:
    ///   - teamId: 팀 ID
    ///   - projectId: 프로젝트 ID
    ///   - timelineId: 삭제할 타임라인 ID
    /// - Returns: 삭제된 타임라인
    func removeTimeline(teamId: Int,
                        projectId: Int,
                        timelineId: Int) -> Observable<ShowTimeline> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .delete,
                                            path: "teams/\(teamId)/projects/\(projectId)/timelines",
                                            httpBody: ["timelineId": timelineId]) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: ShowTimelineDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
}
