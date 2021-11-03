//
//  DateHelper.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import Foundation

class TimeUtils {
    
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM yyyy"

        let date: Date? = dateFormatterGet.date(from: formatter)
        print("Date",dateFormatterPrint.string(from: date!)) // 1 September
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date!)
        
        var day  = "\(anchorComponents.day!)" //dateFormatterPrint.string(from: date!)
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + dateFormatterPrint.string(from: date!)
        
        
    }
}
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
