//
//  Int+Extension.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 27/04/2021.
//

import Foundation

extension Int {
    
    public func getFullDateAsString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    public func getFullTimeAsString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        let timeString = dateFormatter.string(from: date)
        
        return timeString
    }
    
    public func getHourAsString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        let hourString = dateFormatter.string(from: date)
        
        return hourString
    }
    
    public func getWeekDayName() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: date)
        
        return dayString
    }
}
