//
//  Member.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct MemberDTO: Decodable {
    let memberId: Int
    let name: String
    let imageUrl: String
    let username: String
}

extension MemberDTO {
    func toDomain() -> Member {
        Member(memberId: memberId, 
               name: name,
               imageUrl: imageUrl,
               username: username)
    }
}
