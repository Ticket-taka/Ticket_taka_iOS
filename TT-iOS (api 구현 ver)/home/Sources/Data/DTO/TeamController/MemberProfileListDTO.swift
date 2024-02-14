//
//  MemberProfileListDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct MemberProfileListDTO: Decodable {
    let showMemberProfileDtoList: [ShowMemberProfileDTO]
}

extension MemberProfileListDTO {
    func toDomain() -> [ShowMemberProfile] {
        showMemberProfileDtoList
            .map {
                ShowMemberProfile(imageUrl: $0.imageUrl,
                                  name: $0.name,
                                  memberHex: $0.memberHex)
            }
    }
}
