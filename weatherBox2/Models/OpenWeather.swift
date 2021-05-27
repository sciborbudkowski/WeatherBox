//
//  OpenWeather.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import Foundation

struct OpenWeather: Decodable {
    
    let lat: Float
    let lon: Float
    let timezone: String
    let current: WeatherCurrent
    let hourly: [WeatherHourly]
    let daily: [WeatherDaily]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case current
        case hourly
        case daily
    }
}

struct WeatherCurrent: Decodable {
    
    let time: Int
    let sunrise: Int
    let sunset: Int
    let temperature: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Float
    let windDeg: Int
    let weather: [WeatherDetail]
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise
        case sunset
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct WeatherHourly: Decodable {
    
    let time: Int
    let temperature: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Float
    let windDeg: Float
    let windGust: Float
    let weather: [WeatherDetail]
    let pop: Float
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case pop
    }
}

struct WeatherDaily: Decodable {
    
    let time: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Float
    let temperature: Temperature
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let windSpeed: Float
    let windDeg: Float
    let windGust: Float
    let weather: [WeatherDetail]
    let clouds: Int
    let pop: Float
    let uvi: Float
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case clouds
        case pop
        case uvi
    }
}

struct WeatherDetail: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

struct Temperature: Decodable {
    
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let evening: Float
    let morning: Float
    
    enum CodingKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case evening = "eve"
        case morning = "morn"
    }
}

struct FeelsLike: Decodable {
    
    let day: Float
    let night: Float
    let evening: Float
    let morning: Float
    
    enum CodingKeys: String, CodingKey {
        case day
        case night
        case evening = "eve"
        case morning = "morn"
    }
}

struct AirQuality: Decodable {
    
    let list: [AirQualityDetail]
    
    enum CodingKeys: String, CodingKey {
        case list
    }
}

struct AirQualityDetail: Decodable {
    
    let main: Aqi
    let components: AirQualityComponents
    let time: Int
    
    enum CodingKeys: String, CodingKey {
        case main
        case components
        case time = "dt"
    }
}

struct Aqi: Decodable {
    
    let aqi: Int
    
    enum CodingKeys: String, CodingKey {
        case aqi
    }
}

struct AirQualityComponents: Decodable {
    
    let co: Float
    let no: Float
    let no2: Float
    let o3: Float
    let so2: Float
    let pm2_5: Float
    let pm10: Float
    let nh3: Float
    
    enum CodingKeys: String, CodingKey {
        case co
        case no
        case no2
        case o3
        case so2
        case pm2_5
        case pm10
        case nh3
    }
}

typealias AqiTypes = (aqi: Int, icon: String, name: String)

let aqiTypes: [AqiTypes] = [
    AqiTypes(1, "air_good", "Air Good"),
    AqiTypes(2, "air_moderate", "Air Fair"),
    AqiTypes(3, "air_unhealthyForSensitiveGroups", "Air Moderate"),
    AqiTypes(4, "air_unhealthy", "Air Poor"),
    AqiTypes(5, "air_veryUnhealthy", "Air Very Poor")
]

typealias WindSpeed = (minMetric: Float, maxMetric: Float, minImperial: Int, maxImperial: Int, icon: String, name: String, beaufortScale: Int)

let windTypes: [WindSpeed] = [
        WindSpeed(0, 0.5, 0, 1, "wind_calm", "Calm", 0),
        WindSpeed(0.5, 1.5, 1, 3, "wind_lightAir", "Light Air", 1),
        WindSpeed(1.5, 3.3, 3, 7, "wind_lightBreeze", "Light Breeze", 2),
        WindSpeed(3.3, 5.5, 7, 12, "wind_gentleBreeze", "Gentle Breeze", 3),
        WindSpeed(5.5, 7.9, 12, 18, "wind_moderateBreeze", "Moderate Breeze", 4),
        WindSpeed(7.9, 10.7, 18, 24, "wind_freshBreeze", "Fresh Breeze", 5),
        WindSpeed(10.7, 13.8, 24, 31, "wind_strongBreeze", "Strong Breeze", 6),
        WindSpeed(13.8, 17.1, 31, 38, "wind_highWind", "High Wind", 7),
        WindSpeed(17.1, 20.7, 38, 46, "wind_gale", "Gale", 8),
        WindSpeed(20.7, 24.4, 46, 54, "wind_strongGale", "Strong Gale", 9),
        WindSpeed(24.4, 28.4, 54, 63, "wind_storm", "Storm", 10),
        WindSpeed(28.4, 32.6, 63, 72, "wind_violentStorm", "Violent Storm", 11),
        WindSpeed(32.6, 100, 72, 1000, "wind_hurricaneForce", "Hurricane Force", 12)
    ]

typealias Weather = (type: Int, icon: String, name: String)

let weatherTypes: [Weather] = [
    Weather(200, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(201, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(202, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(210, "weather_thunderstorm", "Thunderstorm"),
    Weather(211, "weather_thunderstorm", "Thunderstorm"),
    Weather(212, "weather_thunderstorm", "Thunderstorm"),
    Weather(221, "weather_thunderstorm", "Thunderstorm"),
    Weather(230, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(231, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(232, "weather_thunderstormRain", "Thunderstorm Rain"),
    Weather(300, "weather_drizzle", "Drizzle"),
    Weather(301, "weather_drizzle", "Drizzle"),
    Weather(302, "weather_drizzle", "Drizzle"),
    Weather(310, "weather_drizzle", "Drizzle"),
    Weather(311, "weather_drizzle", "Drizzle"),
    Weather(312, "weather_drizzle", "Drizzle"),
    Weather(313, "weather_drizzle", "Drizzle"),
    Weather(314, "weather_drizzle", "Drizzle"),
    Weather(321, "weather_drizzle", "Drizzle"),
    Weather(500, "weather_rain", "Rain"),
    Weather(501, "weather_rain", "Rain"),
    Weather(502, "weather_rain", "Rain"),
    Weather(503, "weather_rain", "Rain"),
    Weather(504, "weather_rain", "Rain"),
    Weather(511, "weather_rain", "Rain"),
    Weather(520, "weather_rain", "Rain"),
    Weather(521, "weather_rain", "Rain"),
    Weather(522, "weather_rain", "Rain"),
    Weather(531, "weather_rain", "Rain"),
    Weather(600, "weather_snow", "Snow"),
    Weather(601, "weather_snow", "Snow"),
    Weather(602, "weather_snow", "Snow"),
    Weather(611, "weather_snow", "Snow"),
    Weather(612, "weather_snow", "Snow"),
    Weather(613, "weather_snow", "Snow"),
    Weather(615, "weather_snow", "Snow"),
    Weather(616, "weather_snow", "Snow"),
    Weather(620, "weather_snow", "Snow"),
    Weather(621, "weather_snow", "Snow"),
    Weather(622, "weather_snow", "Snow"),
    Weather(701, "weather_mist", "Mist"),
    Weather(711, "weather_mist", "Mist"),
    Weather(721, "weather_mist", "Mist"),
    Weather(731, "weather_mist", "Mist"),
    Weather(741, "weather_mist", "Mist"),
    Weather(751, "weather_mist", "Mist"),
    Weather(761, "weather_mist", "Mist"),
    Weather(762, "weather_mist", "Mist"),
    Weather(771, "weather_mist", "Mist"),
    Weather(781, "weather_mist", "Mist"),
    Weather(800, "weather_clearSky", "Clear Sky"),
    Weather(801, "weather_fewClouds", "Few Clouds"),
    Weather(802, "weather_scatteredClouds", "Scattered Clouds"),
    Weather(803, "weather_brokenClouds", "Broken Clouds"),
    Weather(804, "weather_overcastClouds", "Overcast Clouds")
]

func getWindDirectionSymbol(forWindDirection direction: Int) -> String {
    if direction > 349 && direction <= 12 {
        return "N"
    } else if direction > 12 && direction <= 34 {
        return "NNE"
    } else if direction > 34 && direction <= 57 {
        return "NE"
    } else if direction > 57 && direction <= 79 {
        return "ENE"
    } else if direction > 79 && direction <= 101 {
        return "E"
    } else if direction > 101 && direction <= 124 {
        return "ESE"
    } else if direction > 124 && direction <= 146 {
        return "SE"
    } else if direction > 146 && direction <= 169 {
        return "SSE"
    } else if direction > 169 && direction <= 191 {
        return "S"
    } else if direction > 191 && direction <= 214 {
        return "SSW"
    } else if direction > 214 && direction <= 236 {
        return "SW"
    } else if direction > 236 && direction <= 259 {
        return "WSW"
    } else if direction > 259 && direction <= 281 {
        return "W"
    } else if direction > 281 && direction <= 304 {
        return "WNW"
    } else if direction > 204 && direction <= 326 {
        return "NW"
    } else if direction > 326 && direction <= 349 {
        return "NNW"
    }
    
    return "-"
}
