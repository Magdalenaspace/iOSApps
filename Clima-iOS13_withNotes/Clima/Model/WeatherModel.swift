//
//  WeatherModel.swift
//  Clima
//
//  Created by Magdalena Samuel on 2/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
//here we will define how the weather object would look, be like

struct WeatherModel {

    let conditionID: Int
    let cityName: String
    let temperature: Double
    //we connect these properties with value in pharJSON method
    //in WeatherManager by decoding respove data
    
    
    //here we we create Computed properety:computes the condition of the value
    //automatically calculated and updated whenever the
    //properties they depend on changes
    
    //always give a dateType to a computrd Property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

    var conditionName: String {
        
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max.fill"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }

    }
    
}
