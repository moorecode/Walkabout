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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "mapbox://styles/mapbox/outdoors-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

