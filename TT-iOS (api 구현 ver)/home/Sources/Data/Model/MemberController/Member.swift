//
//  Member.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct Member: Decodable {
    let memberId: Int
    let name: String
    let imageUrl: String
    let username: String
}
