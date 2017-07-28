//
//  ViewController.swift
//  Walkabout
//
//  Created by Sam Moore on 28/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import Mapbox
import SnapKit
import Alamofire
import SwiftyJSON
import RealmSwift

enum DataSet: String {
    case ACTArtsFacilitiesList = "https://www.data.act.gov.au/resource/n2d8-bhdk.json"
    case ACTPublicArtList = "https://www.data.act.gov.au/resource/s538-zqvb.json"
    case DrinkingFountains = "https://www.data.act.gov.au/resource/b9vw-nui5.json"
    case FencedDogParks = "https://www.data.act.gov.au/resource/agh7-cjq8.json"
    case FitnessSites = "https://www.data.act.gov.au/resource/4x3y-6wz4.json"
    case PublicBarbequesintheACT = "https://www.data.act.gov.au/resource/ti8x-vy4v.json"
    case PublicFurnitureintheACT = "https://www.data.act.gov.au/resource/knzq-ianp.json"
    case PublicToiletsintheACT = "https://www.data.act.gov.au/resource/s5ui-t9rd.json"
    case TownAndDistrictPlaygrounds = "https://www.data.act.gov.au/resource/9y36-yxpi.json"
}

class ViewController: UIViewController {
    
    let dataSets:[DataSet] = [.ACTArtsFacilitiesList, .ACTPublicArtList, .DrinkingFountains, .FencedDogParks, .FitnessSites, .PublicBarbequesintheACT, .PublicFurnitureintheACT, .PublicToiletsintheACT, .TownAndDistrictPlaygrounds]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "mapbox://styles/mapbox/outdoors-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url = "https://www.data.act.gov.au/resource/n2d8-bhdk.json"
        Alamofire.request(url).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let json = JSON(data: data)
                for (_,subJson):(String, JSON) in json {
                    print(subJson["facility"])
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

