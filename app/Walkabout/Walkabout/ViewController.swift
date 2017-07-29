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
        
        let getter = DataGetter()
        getter.getData()
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "mapbox://styles/mapbox/outdoors-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        view.addSubview(mapView)
        
        // Bottom SubView for initiation of Walkabout
        let bottomOverlay = UIView()
        bottomOverlay.frame = view.bounds
        bottomOverlay.backgroundColor = UIColor.clear
        view.addSubview(bottomOverlay)
        
        // Set the constraints of the bottom overlay
        bottomOverlay.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
        }
        
        // Force the bottom overlay to be at the front at all times
        bottomOverlay.layer.zPosition = CGFloat.greatestFiniteMagnitude
        bottomOverlay.layer.cornerRadius = 5
        bottomOverlay.layer.masksToBounds = true;
        
        // Create a blur effect subview that represents
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEfffectView = UIVisualEffectView(effect:blurEffect)
        blurEfffectView.frame = bottomOverlay.bounds
        blurEfffectView.layer.cornerRadius = 5
        blurEfffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomOverlay.addSubview(blurEfffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

