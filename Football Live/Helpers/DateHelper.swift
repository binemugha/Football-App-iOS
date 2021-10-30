//
//  DateHelper.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import Foundation

struct DateManager {
    static func today() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
}

extension Date {
    func toSting() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: self)
        return formattedDate
    }
}
