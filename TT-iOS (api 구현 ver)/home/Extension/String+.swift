//
//  String+.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func toDate(separatedBy: String = "-") -> Date? {
        let splitedDate = self.components(separatedBy: separatedBy)
            .map{ Int($0) }
        guard splitedDate.count >= 3 else { return nil }
        let (year, month, day) = (splitedDate[0], splitedDate[1], splitedDate[2])
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return calendar.date(from: dateComponents)
    }
}
