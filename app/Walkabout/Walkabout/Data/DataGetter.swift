//
//  DataGetter.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class DataGetter: NSObject {
    
    
    func getData() {
        
        // delete all form Realm
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        
        // art facility
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        var url = "https://www.data.act.gov.au/resource/n2d8-bhdk.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["facility"])
                    print(subJson["location"]["coordinates"][1])
                    print(subJson["location"]["coordinates"][0])
                    let place = ArtFacility()
                    place.name = subJson["facility"].stringValue
                    place.address = subJson["address"].stringValue
                    place.lat = subJson["location"]["coordinates"][1].floatValue
                    place.lon = subJson["location"]["coordinates"][0].floatValue
                    place.url = subJson["url"].stringValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        
        
    // art item
        
     url = "https://www.data.act.gov.au/resource/s538-zqvb.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["title"])
                    print(subJson["longitude"]["coordinates"][1])
                    print(subJson["longitude"]["coordinates"][0])
                    let place = ArtItem()
                    place.name = subJson["title"].stringValue
                    place.lat = subJson["longitude"]["coordinates"][1].floatValue
                    place.lon = subJson["longitude"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        
        
        // drinking fountain
        
        url = "https://www.data.act.gov.au/resource/b9vw-nui5.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["location_1"]["coordinates"][1])
                    print(subJson["location_1"]["coordinates"][0])
                    let place = DrinkingFountain()
                    place.lat = subJson["location_1"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        // dog park
        
        url = "https://www.data.act.gov.au/resource/agh7-cjq8.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["location_1"]["coordinates"][1])
                    print(subJson["location_1"]["coordinates"][0])
                    let place = DogPark()
                    place.lat = subJson["location_1"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        // beach
        
        
        url = "https://www.data.act.gov.au/resource/gtig-tf5m.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["the_geom"]["coordinates"][1])
                    print(subJson["the_geom"]["coordinates"][0])
                    let place = Beach()
                    place.name = subJson["name"].stringValue.capitalized
                    place.lat = subJson["the_geom"]["coordinates"][1].floatValue
                    place.lon = subJson["the_geom"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        
        
        //fitness site
    

        url = "https://www.data.act.gov.au/resource/4x3y-6wz4.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["location"])
                    print(subJson["type"])
                    print(subJson["location_1_2"]["coordinates"][1])
                    print(subJson["location_1_2"]["coordinates"][0])
                    let place = FitnessSite()
                    place.type = subJson["type"].stringValue
                    place.location = subJson["location"].stringValue
                    place.lat = subJson["location_1_2"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1_2"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        // barbeque
        
        url = "https://www.data.act.gov.au/resource/ti8x-vy4v.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["location"])
                    print(subJson["bbq_type"])
                    print(subJson["location_1_2"]["coordinates"][1])
                    print(subJson["location_1_2"]["coordinates"][0])
                    let place = Barbeque()
                    place.type = subJson["bbq_type"].stringValue
                    place.location = subJson["location"].stringValue
                    place.lat = subJson["location_1"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        // furniture
        
        url = "https://www.data.act.gov.au/resource/knzq-ianp.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["location"])
                    print(subJson["feature_type"])
                    print(subJson["location_1"]["coordinates"][1])
                    print(subJson["location_1"]["coordinates"][0])
                    let place = Furniture()
                    place.type = subJson["feature_type"].stringValue.capitalized
                    place.location = subJson["location_name"].stringValue.capitalized
                    place.lat = subJson["location_1"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        // toilet
        
        url = "https://www.data.act.gov.au/resource/s5ui-t9rd.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["toilet_type_text"])
                    print(subJson["location"]["coordinates"][1])
                    print(subJson["location"]["coordinates"][0])
                    let place = Toilet()
                    place.type = subJson["toilet_type_text"].stringValue.capitalized
                    place.lat = subJson["location"]["coordinates"][1].floatValue
                    place.lon = subJson["location"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
        
        
        // playground
        
        url = "https://www.data.act.gov.au/resource/9y36-yxpi.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["equipment"])
                    print(subJson["location"])
                    print(subJson["location_1"]["coordinates"][1])
                    print(subJson["location_1"]["coordinates"][0])
                    let place = Playground()
                    place.equipment = subJson["equipment"].stringValue
                    place.location = subJson["location"].stringValue
                    place.lat = subJson["location_1"]["coordinates"][1].floatValue
                    place.lon = subJson["location_1"]["coordinates"][0].floatValue
                    print(place)
                    try! realm.write {
                        realm.add(place)
                    }
                }
            }
        }
    }

}
