//
//  TTNetworkService.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit
import RxSwift

final class TTNetworkService: NetworkService {
    static let shared: TTNetworkService = TTNetworkService()
    let baseURL: URL
    let deviceId: String = UIDevice.current.identifierForVendor!.uuidString
    
    private init() {
        self.baseURL = URL(string: URL.baseURL)!
    }
}


