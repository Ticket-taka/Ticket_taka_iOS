//
//  ShowMemberProfileDTO.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct ShowMemberProfileDTO: Decodable {
    let imageUrl: String
    let name: String
    let memberHex: String
}

extension ShowMemberProfileDTO {
    func toDomain() -> ShowMemberProfile {
        ShowMemberProfile(imageUrl: imageUrl,
                          name: name,
                          memberHex: memberHex)
    }
}

