//
//  Date+.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation

extension Date {
    func toString(_ dateFormat: String = "yyyy-MM-dd",
                  localeIdentifier: String = "ko_KR") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
