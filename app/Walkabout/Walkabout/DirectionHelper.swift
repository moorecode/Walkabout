//
//  Directions.swift
//  Walkabout
//
//  Created by Alexander Eckersley on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import Foundation
import MapboxDirections
import Mapbox
import Polyline
import RealmSwift

class DirectionsHelpers {
    
    var cap = 3
    
    func regenerateAndDisplay(waypoints:[Waypoint], mapView:MGLMapView){
        
        let directions = Directions.shared
        var newWayPoints = waypoints
        
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
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    mapView.addAnnotation(routeLine)
                    mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: .zero, animated: true)
                }
                
            }
        }
        
    }
    
    func GenerateAndDisplay(waypoints:[Waypoint], mapView:MGLMapView){
    
        let directions = Directions.shared
        var newWayPoints = waypoints
        
        let options = RouteOptions(waypoints: waypoints, profileIdentifier: .walking)
        options.includesSteps = true
        
        let task = directions.calculate(options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, let leg = route.legs.first {
                
                let distanceFormatter = LengthFormatter()
                let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
                
                let travelTimeFormatter = DateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .short
                let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
                
                
                for step in leg.steps {
                    let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                }
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    for coordinate in routeCoordinates {
                        
                        let realm = try! Realm()
                        let furniture = realm.objects(Furniture.self)
                        for t in furniture {
                            let coordinate0 = CLLocation(latitude: Double(t.lat), longitude: Double(t.lon))
                            let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let distance = coordinate0.distance(from: coordinate1)
                            
                            if distance < 250 && self.cap < 25 {
                                //print("FURNITURE CANDIDATE. ADJUSTING ROUTE")
                                let waypoint = Waypoint(location: coordinate0)
                                waypoint.coordinateAccuracy = -1
                                self.cap += 1
                                newWayPoints.insert(waypoint, at: (waypoints?.count)!-2)
                                break;
                                
                            }
                            
                        }
                        
                        let toilets = realm.objects(Toilet.self)
                        for t in toilets {
                            let coordinate0 = CLLocation(latitude: Double(t.lat), longitude: Double(t.lon))
                            let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let distance = coordinate0.distance(from: coordinate1)
                            
                            if distance < 250 && self.cap < 25 {
                                //print("TOILET CANDIDATE. ADJUSTING ROUTE")
                                let waypoint = Waypoint(location: coordinate0)
                                self.cap += 1
                                waypoint.coordinateAccuracy = -1
                                newWayPoints.insert(waypoint, at: (waypoints?.count)!-2)
                                break;
                                
                            }
                            
                        }
                        
                        let art = realm.objects(ArtItem.self)
                        for t in art {
                            let coordinate0 = CLLocation(latitude: Double(t.lat), longitude: Double(t.lon))
                            let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let distance = coordinate0.distance(from: coordinate1)
                            
                            if distance < 250 && self.cap < 25 {
                                //print("ART CANDIDATE. ADJUSTING ROUTE")
                                let waypoint = Waypoint(location: coordinate0)
                                waypoint.coordinateAccuracy = -1
                                self.cap += 1
                                newWayPoints.insert(waypoint, at: (waypoints?.count)!-2)
                                break;
                                
                            }
                            
                        }
                        
                        let barbeque = realm.objects(Barbeque.self)
                        for t in barbeque {
                            let coordinate0 = CLLocation(latitude: Double(t.lat), longitude: Double(t.lon))
                            let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let distance = coordinate0.distance(from: coordinate1)
                            
                            if distance < 250 && self.cap < 25 {
                                //print("BARBEQUE CANDIDATE. ADJUSTING ROUTE")
                                let waypoint = Waypoint(location: coordinate0)
                                waypoint.coordinateAccuracy = -1
                                self.cap += 1
                                newWayPoints.insert(waypoint, at: (waypoints?.count)!-2)
                                break;
                                
                            }
                            
                        }
                        
                        let fountain = realm.objects(DrinkingFountain.self)
                        for t in fountain {
                            let coordinate0 = CLLocation(latitude: Double(t.lat), longitude: Double(t.lon))
                            let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let distance = coordinate0.distance(from: coordinate1)
                            
                            if distance < 250 && self.cap < 25 {
                                //print("FOUNTAIN CANDIDATE. ADJUSTING ROUTE")
                                let waypoint = Waypoint(location: coordinate0)
                                waypoint.coordinateAccuracy = -1
                                self.cap += 1
                                newWayPoints.insert(waypoint, at: (waypoints?.count)!-2)
                                break;

                                
                            }
                            
                        }
                        
                    }
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    routeLine.title = "PreStroke"
                    mapView.addAnnotation(routeLine)
                    mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: .zero, animated: true)
                    
                    self.regenerateAndDisplay(waypoints: newWayPoints, mapView: mapView)
                }
                
            }
        }
        
    }
    
}

