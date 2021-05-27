//
//  Season.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 27/04/2021.
//

import Foundation

enum Seasons: String {
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
}

enum DayParts: String {
    case day = "Day"
    case night = "Night"
}

class Season {
    
    public static func getSeason() -> Seasons {
        let date = Date()
        
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .year, for: date)!
        
        if day >= 81 && day < 174 {
            return .spring
        }
        if day >= 175 && day < 267 {
            return .summer
        }
        if day >= 267 && day < 359 {
            return .autumn
        }
        
        return .winter
    }
    
    public static func getTags(for season: Seasons) -> [String] {
        switch season {
        case .spring:
            return ["spring", "nature"]
            
        case .summer:
            return ["summer", "nature"]
            
        case .autumn:
            return ["autumn", "nature"]
            
        case .winter:
            return ["winter", "nature"]
        }
    }
    
    public static func getDayPart(for timestamp: Int, sunrise: Int, sunset: Int) -> DayPart {
        if timestamp > sunrise && timestamp < sunset {
            return .day
        }
        
        return .night
    }
}
