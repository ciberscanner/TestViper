//
//  AppConstants.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation

//let API: String = "http://api.geonames.org/timezoneJSON?formatted=true&lat=4.672087&lng=-74.091328&username=qa_mobile_easy&style=full"

public class MyAPI{
    public static func getUrlAPI(lat: String, lon: String)->String{
        return "http://api.geonames.org/timezoneJSON?formatted=true&lat=\(lat)&lng=\(lon)&username=qa_mobile_easy&style=full"
    }
}
