//
// DateUtils.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import Foundation


class DateUtils {
    
    static let  shared = DateUtils()
   private init() {}
    private let dateFormatter: DateFormatter = DateFormatter()

    
    enum DateFormat:String {
        case startWithYear = "yyyy-MM-dd"
        case startWithDay = "dd-MM-yyyy"
        case apiFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    
     func convertDateToString(date:Date, dateFormat:DateFormat) -> String? {
        dateFormatter.dateFormat = dateFormat.rawValue
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func convertStringToDate(dateString:String, dateFormat:DateFormat) -> Date? {
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: dateString)
    }
    
    func startEndDateFilter(days:Double = 365)->(start:String,end:String){
        let start = Date()
        let end = start.addingTimeInterval(86400 * (days))
       
        let startText = convertDateToString(date: start, dateFormat: .startWithYear) ?? ""
        let endText = convertDateToString(date: end, dateFormat: .startWithYear ) ?? ""
        return (startText,endText)
    }
    
}

