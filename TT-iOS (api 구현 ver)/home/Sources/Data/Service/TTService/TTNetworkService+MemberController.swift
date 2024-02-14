//
//  TTNetworkService+MemberController.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

// MARK: - Member Controller
extension TTNetworkService {
    /// 회원가입
    /// - Parameters:
    ///   - name: 이름
    ///   - username: username
    ///   - password: password
    ///   - password2: password2
    ///   - imageUrl: imageUrl
    ///   - email: email
    /// - Returns: 회원 가입된 멤버 ID
    func signUp(name: String,
                username: String,
                password: String,
                password2: String,
                imageUrl: String,
                email: String) -> Observable<Int> {
        let signUpUserDto = SignUpUserDTO(name: name,
                                          username: username,
                                          password: password,
                                          password2: password2,
                                          imageUrl: imageUrl,
                                          deviceToken: deviceId,
                                          providerType: "iOS",
                                          email: email)
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "members/sign-up",
                                            httpBodyObject: signUpUserDto) else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: SignUpResultDTO.self)
        .map { $0.memberId }
        .asObservable()
    }
    
    /// 로그인
    /// - Parameters:
    ///   - username: 사용자 ID
    ///   - password: 비밀번호
    ///   - keepStatus: ?
    /// - Returns: Member Profile
    func signIn(username: Int,password: Int,
                keepStatus: Bool) -> Observable<[ShowMemberProfile]> {
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .get,
                                            path: "members/sign-in") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: MemberProfileListDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
    
    
    
    /// 유저 정보 수정
    /// - Parameters:
    ///   - memberId: 멤버 ID
    ///   - image: 이미지
    ///   - name: 이름
    ///   - username: 아이디
    ///   - password: 비밀번호
    /// - Returns: Member
    func updateUser(memberId: Int,
                    image: UIImage,
                    name: String,
                    username: String,
                    password: String) -> Observable<Member> {
        let updateUserDto = UpdateUserDTO(image: image.toPngString(),
                                          request: .init(name: name,
                                                         username: username,
                                                         password: password))
        guard let urlRequest = TTURLRequest(url: baseURL,
                                            method: .patch,
                                            path: "members/\(memberId)") else {
            return Observable.error(NetworkError.badRequestError)
        }
        return response(urlRequest,
                        type: MemberDTO.self)
        .map { $0.toDomain() }
        .asObservable()
    }
}
