//
//  ResponseAPI.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
public class ResponseAPI: Decodable {
    public let sunrise: String
    public let lng: Double
    public let countryCode: String
    public let gmtOffset, rawOffset: Int
    public let sunset, timezoneID: String
    public let dstOffset: Int
    public let countryName, time: String
    public let lat: Double

    enum CodingKeys: String, CodingKey {
        case sunrise, lng, countryCode, gmtOffset, rawOffset, sunset
        case timezoneID = "timezoneId"
        case dstOffset, countryName, time, lat
    }

    public init(sunrise: String, lng: Double, countryCode: String, gmtOffset: Int, rawOffset: Int, sunset: String, timezoneID: String, dstOffset: Int, countryName: String, time: String, lat: Double) {
        self.sunrise = sunrise
        self.lng = lng
        self.countryCode = countryCode
        self.gmtOffset = gmtOffset
        self.rawOffset = rawOffset
        self.sunset = sunset
        self.timezoneID = timezoneID
        self.dstOffset = dstOffset
        self.countryName = countryName
        self.time = time
        self.lat = lat
    }
}
