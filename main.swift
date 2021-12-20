//
//  main.swift
//  Parser
//
//  Created by AAI20022 on 18.12.2021.
//  Copyright © 2021 AAI20022. All rights reserved.
//

import Foundation

func main() {
    let BaseY = 48.471207
    let BaseX = 35.038810    
        
    if let path = Bundle.main.path(forResource: "file", ofType: "json") {
        let json = JSONParserPlaces(JsonPath: path)
           
        let res = CoolPlacesNearMe(JSON: json, BasePointX: BaseX, BasePointY: BaseY, Distance: 5)
        print(res.getPlacesNames())
    }
}

main()

