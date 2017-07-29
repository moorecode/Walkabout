//
//  InterfaceController.swift
//  WalkaboutWatch Extension
//
//  Created by Alexander Eckersley on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import WatchKit
import Foundation
import MapboxStatic

class InterfaceController: WKInterfaceController {
        @IBOutlet var imageView: WKInterfaceImage!
    
        override func awake(withContext context: Any?) {
                super.awake(withContext: context)
                let camera = SnapshotCamera (lookingAtCenter: CLLocationCoordinate2D(latitude: -35.274452, longitude: 149.098478), zoomLevel: 7)
                camera.pitch = 60
                let styleUrl = URL(string: "mapbox://styles/jbwhitcombe/cj5ol2ww602w62rldbmxda5dy")
                let options = SnapshotOptions(styleURL: styleUrl!, camera: camera, size: CGSize(width: 200, height: 200))
            
                let snapshot = Snapshot(options: options, accessToken: "pk.eyJ1IjoiamJ3aGl0Y29tYmUiLCJhIjoiY2o1b2s2N3RhMDB6NjMzcHFwZTJmbDJsdCJ9.KgiXUqT9bHXVulRlN7Ch6Q")
            
                imageView.setImage(snapshot.image)
            
                // Configure interface objects here.
            }
    
        override func willActivate() {
                // This method is called when watch view controller is about to be visible to user
                super.willActivate()
            
            }
    
        override func didDeactivate() {
                // This method is called when watch view controller is no longer visible
                super.didDeactivate()
            }
    
}
