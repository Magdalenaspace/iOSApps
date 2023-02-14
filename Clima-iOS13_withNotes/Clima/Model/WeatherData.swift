//
//  WeatherData.swift
//  Clima
//
//  Created by Magdalena Samuel on 2/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


//look in the url with the id and
//see the properties of the API object->
//breack down the structure
//for compiler to chue the data
//so we can assighn property names
//and turn into a swift object
//WeatherData needs to adupt Decodable protocol
//meaning the WeatherData turned into a type that can decode itself from an external representation
//namely the JSON representation
//WeatherData is Decodable go to Weather Manager initilise it as let decoder


//typealias codable = Decodable + encodable

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

//property names have to maych with JSON object
//you can copy the path of value/ pathe from the json page
//in order do use the path of the JSON data, have to take the entire piece of data propery
//a object with five items, and that object has these properties: temp, pressure, humidity,
//That means we actually need another struct which I'm just going to call Main.
//And this, again, has to be Decodedable.
struct Main: Codable {
    let temp: Double
    //use the Main as a DataType Of Weather Data
    
}

struct Weather: Codable {
    //We use Api id condition code these uds corespond to nthe different weather condions
    //we get hold of this id to match the sfSymbol image with switch statement -> wheather manager
    let id: Int
    //use the Main as a DataType Of Weather Data
    
}
//    "coord": {2 items},
//    "weather": [1 item],
//    "base": "stations",
//    "main": {8 items},
//    "visibility": 4125,
//    "wind": {3 items},
//    "clouds": {1 item},
//    "dt": 1676220250,
//    "sys": {5 items},
//    "timezone": 28800,
//    "id": 1650535,
//    "name": "Bali",
//    "cod": 200 <---------Json object string properties
//
    
