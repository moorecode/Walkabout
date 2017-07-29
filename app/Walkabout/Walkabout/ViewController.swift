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
        let url = URL(string: "mapbox://styles/jbwhitcombe/cj5ol2ww602w62rldbmxda5dy")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        mapView.compassView.isHidden = true
        view.addSubview(mapView)

        let center = CLLocationCoordinate2D(latitude: -35.274452, longitude: 149.098478)
        mapView.setCenter(center, zoomLevel: 7, direction: 0, animated: false)
        
        // Bottom SubView for initiation of Walkabout
        let bottomOverlay = UIView()
        bottomOverlay.frame = view.bounds
        bottomOverlay.backgroundColor = UIColor.gray
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
        //bottomOverlay.addSubview(blurEfffectView)
        
        let btn = UIButton(type: .custom) as UIButton
        btn.backgroundColor = .clear
        btn.setTitle("Walkabout", for: .normal)
        btn.frame = bottomOverlay.frame
        bottomOverlay.addSubview(btn)
        
        btn.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(bottomOverlay.snp.centerX)
            make.bottom.equalTo(bottomOverlay.snp.bottom)
            make.left.equalTo(bottomOverlay.snp.left)
            make.right.equalTo(bottomOverlay.snp.right).dividedBy(2)
            make.height.equalTo(bottomOverlay.snp.height)
        }
        
        btn.addTarget(self, action: #selector(clickMe), for: .touchUpInside)

    }

    @objc func clickMe(sender:UIButton!) {
        print("Get cucked")
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

extension ViewController: MGLMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.
        
        // Create a camera that rotates around the same center point, rotating 180°.
        // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, fromDistance: 4500, pitch: 15, heading: 180)
        
        // Animate the camera movement over 5 seconds.
        mapView.setCamera(camera, withDuration: 120, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
    }
    
}

