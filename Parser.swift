//
//  Parser.swift
//  Parser
//
//  Created by AAI20022 on 18.12.2021.
//  Copyright © 2021 AAI20022. All rights reserved.
//

import Foundation

struct Place {
    var name : String
    var lat : Double
    var lng : Double
    
    init(AnyValue: Any) {
        let temp = AnyValue as? [String: Any] ?? [String: Any]()
        name = temp["name"] as? String ?? ""
        let tempGeometry = temp["geometry"]
        let locationTemp = tempGeometry as? [String: Any] ?? [String: Any]()
        let location = locationTemp["location"] as! [String: Any]
        lat = location["lat"] as? Double ?? 0
        lng = location["lng"] as? Double ?? 0
    }
}

class JSONParserPlaces {
    
    private var Places = [Place]()
    
    private func parseProcessing(JsonPath: String) -> [String: Any]? {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: JsonPath))
            var dictionary: [String: Any]?
            do {
                guard let dictionaryTry = try
                JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                as? [String: Any] else { return nil }
                dictionary = dictionaryTry
            }
            catch {
                print("Error while JsonSerialization! [JSONParserPlaces::parseProcessing], error description:  \(error.localizedDescription)")
            }

            return dictionary
        }
        catch {
                print("Error while reading json file! [JSONParserPlaces::parseProcessing], error description:  \(error.localizedDescription)")
            return nil
        }
    }
    
    public init(JsonPath: String) {
        guard let dictionary = parseProcessing(JsonPath: JsonPath)
            else { return }
        let candidatesArray = dictionary["candidates"] as! [Any]
        for i in 0..<candidatesArray.count {
            Places.append(Place(AnyValue: candidatesArray[i]))
        }
    }
    
    public func Name(_ Index: Int) -> String { return Places[Index].name }
    
    public func Lat(_ Index: Int) -> Double { return Places[Index].lat }

    public func Lng(_ Index: Int) -> Double { return Places[Index].lng }
    
    public func get(_ Index: Int) -> Place { return Places[Index] }
    
    public func count() -> Int { return Places.count }
}
