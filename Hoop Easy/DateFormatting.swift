//
//  DateFormatting.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/27/24.
//

import Foundation

/*
 time: String should be in format "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
 */
func utcToLocal(time: String) -> (String, String)? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

    if let date = dateFormatter.date(from: time) {
        dateFormatter.timeZone = TimeZone.current
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatted.string(from: date)
        
        let timeFormatted = DateFormatter()
        timeFormatted.dateFormat = "hh:mm:ss a"
        let timeString = timeFormatted.string(from: date)
        
        return (dateString, timeString)
    } else {
        print("Invalid date format")
        return nil
    }
}
