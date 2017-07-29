//
//  ViewControllerTestRoutes.swift
//  Walkabout
//
//  Created by Alexander Eckersley on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import Mapbox
import MapboxDirections

class ViewControllerTestRoutes: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let directions = Directions.shared
        
        let waypoints = [
            Waypoint(
                coordinate: CLLocationCoordinate2D(latitude: -35.235805 , longitude: 149.068165),
                name: "Belconnen Arts Centre"),
            Waypoint(
                coordinate: CLLocationCoordinate2D(latitude: -35.281746, longitude: 149.122345),
                name: "Ainslie Arts Centre"),]
        
        let options = RouteOptions(waypoints: waypoints, profileIdentifier: .walking)
        options.includesSteps = true
        
        let task = directions.calculate(options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, let leg = route.legs.first {
                print("Route via \(leg):")
                
                let distanceFormatter = LengthFormatter()
                let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
                
                let travelTimeFormatter = DateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .short
                let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
                
                print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
                
                for step in leg.steps {
                    print("\(step.instructions)")
                    let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                    print("— \(formattedDistance) —")
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
