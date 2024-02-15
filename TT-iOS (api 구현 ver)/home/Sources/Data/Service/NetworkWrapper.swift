//
//  NetworkWrapper.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

struct NetworkResponseWrapper<T: Decodable>: Decodable {
    let code: String
    let message: String
    let result: T?
    let isSuccess: Bool
}
