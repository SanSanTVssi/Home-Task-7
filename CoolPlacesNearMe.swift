//
//  CoolPlacesNearMe.swift
//  HT7
//
//  Created by AAI20022 on 18.12.2021.
//  Copyright 2021 AAI20022. All rights reserved.
//

import Foundation

struct CoolPlace {
    var title: String
    var distance: Double
}

func Haversine (_ lngBase: Double,_ lanBase: Double,
              _ lng: Double, _ lan: Double) -> Double
{
    let degToRad: Double = Double.pi / 180
    
    return 2 * 6372795/1000 * asin(sqrt(pow(sin((lanBase - lan) * degToRad/2), 2)
        + cos(lanBase * degToRad) * cos(lan * degToRad) * pow(sin((lngBase - lng) * degToRad/2), 2)))
}

class CoolPlacesNearMe {

    private var Json: JSONParserPlaces

    var basePointX: Double

    var basePointY: Double

    var distance: Double

    public init(Filename: String, BasePointX: Double, BasePointY: Double, Distance: Double) {
        Json = JSONParserPlaces(JsonPath: Filename)
        basePointX = BasePointX
        basePointY = BasePointY
        distance = Distance
    }

    public init(JSON: JSONParserPlaces, BasePointX: Double, BasePointY: Double, Distance: Double) {
        Json = JSON
        basePointX = BasePointX
        basePointY = BasePointY
        distance = Distance
    }

    func JsonReplece(JsonPath: String) { Json = JSONParserPlaces(JsonPath: JsonPath) }

    func JsonReplece(JSON: JSONParserPlaces) { Json = JSON }

    func getPlacesNames() -> [CoolPlace] {
        var resultArray = [CoolPlace]()
        for i in 0..<Json.count() {
            let x = Json.Lng(i)
            let y = Json.Lat(i)
            let countDistanceRes = Haversine(basePointX, basePointY,
                                             x, y)
            if (countDistanceRes < distance && Json.Name(i) != "") {
                resultArray.append(
                    CoolPlace(
                        title: Json.Name(i),
                        distance: countDistanceRes
                    )
                )
            }
        }
        return resultArray
    }
}
