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
import ChameleonFramework
import SwiftyButton
import MapboxDirections
import Polyline
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let walkaboutButton = PressableButton()
    var mapView: MGLMapView?
    
    var url = URL(string: "")
    
    var pointRegister: [String: AnyClass] = [:]
    let LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Observe screen brightness
        NotificationCenter.default.addObserver(self,selector: #selector(screenBrightnessDidChange(_:)),name: NSNotification.Name.UIScreenBrightnessDidChange,object: nil)
        
        if UIScreen.main.brightness > 0.5 {
            url = URL(string: "mapbox://styles/jbwhitcombe/cj5ol2ww602w62rldbmxda5dy")
        }else {
            url = URL(string: "mapbox://styles/jbwhitcombe/cj5okh01801t42sr1d31s324l")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        guard let map = mapView else {fatalError("Map could no be initialzed")}
        map.delegate = self
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.logoView.isHidden = true
        map.attributionButton.isHidden = true
        map.compassView.isHidden = true
        view.addSubview(map)
        
        let center = CLLocationCoordinate2D(latitude: -35.274452, longitude: 149.098478)
        map.setCenter(center, zoomLevel: 7, direction: 0, animated: false)
        
        walkaboutButton.colors = .init(button: UIColor.flatGreen(), shadow: UIColor.flatGreenColorDark())
        walkaboutButton.setTitle("Walkabout", for: .normal)
        
        walkaboutButton.titleLabel?.font = UIFont(name: "Archive", size: 26)
        view.addSubview(walkaboutButton)
        
        walkaboutButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.left.equalTo(view.snp.leftMargin).offset(16)
            make.right.equalTo(view.snp.rightMargin).offset(-16)
            make.height.equalTo(50)
        }
        
        walkaboutButton.addTarget(self, action: #selector(walkaboutButtonTapped), for: .touchUpInside)
        
        let directionsButton = PressableButton()
        directionsButton.colors = .init(button: UIColor.flatBlue(), shadow: UIColor.flatBlueColorDark())
        directionsButton.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        directionsButton.imageEdgeInsets = UIEdgeInsetsMake(30,30,30,30)
        view.addSubview(directionsButton)
        directionsButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        let realm = try! Realm()
        let artFacilities = realm.objects(ArtFacility.self)
        let artItems = realm.objects(ArtItem.self)
        let drinkingFountains = realm.objects(DrinkingFountain.self)
        let dogParks = realm.objects(DogPark.self)
        let fitnessSites = realm.objects(FitnessSite.self)
        let bbqs = realm.objects(Barbeque.self)
        let furniture = realm.objects(Furniture.self)
        let toilets = realm.objects(Toilet.self)
        let playgrounds = realm.objects(Playground.self)
        var pointAnnotations = [MGLPointAnnotation]()
       
        for ai in artItems {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(ai.lat), longitude: CLLocationDegrees(ai.lon))
            point.title = "Artwork"
            point.subtitle = ai.name
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(ai.lat)) + String(CLLocationDegrees(ai.lon))] = ArtItem.self
        }
        for d in drinkingFountains {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(d.lat), longitude: CLLocationDegrees(d.lon))
            point.title = "Drinking Fountain"
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(d.lat)) + String(CLLocationDegrees(d.lon))] = DrinkingFountain.self
        }
        for d in dogParks {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(d.lat), longitude: CLLocationDegrees(d.lon))
            point.title = "Dog Park"
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(d.lat)) + String(CLLocationDegrees(d.lon))] = DogPark.self
        }
        for f in fitnessSites {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(f.lat), longitude: CLLocationDegrees(f.lon))
            point.title = "Fitness Equipment"
            point.subtitle = f.type
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(f.lat)) + String(CLLocationDegrees(f.lon))] = FitnessSite.self
        }
        for f in furniture {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(f.lat), longitude: CLLocationDegrees(f.lon))
            point.title = "Public Furniture"
            point.subtitle = f.type
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(f.lat)) + String(CLLocationDegrees(f.lon))] = Furniture.self
        }
        for b in bbqs {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(b.lat), longitude: CLLocationDegrees(b.lon))
            point.title = "Barbeque"
            point.subtitle = b.type
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(b.lat)) + String(CLLocationDegrees(b.lon))] = Barbeque.self
        }
        for t in toilets {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(t.lat), longitude: CLLocationDegrees(t.lon))
            point.title = "Toilet"
            point.subtitle = t.type
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(t.lat)) + String(CLLocationDegrees(t.lon))] = Toilet.self
        }
        
        for p in playgrounds {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(p.lat), longitude: CLLocationDegrees(p.lon))
            point.title = "Playground"
            point.subtitle = p.equipment
            pointAnnotations.append(point)
            pointRegister[String(CLLocationDegrees(p.lat)) + String(CLLocationDegrees(p.lon))] = Toilet.self
        }
 

        print(pointAnnotations)
        map.addAnnotations(pointAnnotations)

        
    }
    
    func commenceRouteDrawing(items: [AnyClass]) {
        // JOSH
        mapView?.showsUserLocation = true
        let helper = DirectionsHelpers.init()
        let point1 = Waypoint(coordinate: (mapView?.userLocation?.coordinate)!)
        let point2 = Waypoint(coordinate: CLLocationCoordinate2D(latitude: -35.279, longitude: 149.05))
        let waypoints = [point1, point2]
        helper.GenerateAndDisplay(waypoints:waypoints, mapView:self.mapView!)
    }
    
    func screenBrightnessDidChange(_ notification: Notification) {
        
        if UIScreen.main.brightness > 0.5 {
            url = URL(string: "mapbox://styles/jbwhitcombe/cj5ol2ww602w62rldbmxda5dy")
        }
            
        else {
            url = URL(string: "mapbox://styles/jbwhitcombe/cj5okh01801t42sr1d31s324l")
        }
        
    }
    
    @objc func walkaboutButtonTapped(sender:UIButton!) {
        
        // Setup completion handler for setUpViewController
        let completionHandler:(SetupViewController)->Void = { childVC in
            
            // Call whatever the fuck you want here
            for c in childVC.output {
                print(String(describing: c))
            }
            
            self.commenceRouteDrawing(items: childVC.output)
            
        }
        
        let setupView = SetupViewController()
        setupView.preferredContentSize = CGSize(width: 300, height: 400)
        setupView.modalPresentationStyle = .popover
        
        // Assigns the completion handler to the function above
        setupView.completionHandler = completionHandler
        setupView.popoverPresentationController?.permittedArrowDirections = .down
        setupView.popoverPresentationController?.delegate = self
        setupView.popoverPresentationController?.sourceView = walkaboutButton
        setupView.popoverPresentationController?.sourceRect = walkaboutButton.bounds
        self.present(setupView, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UITextField: UITextFieldDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
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
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = String(describing:pointRegister[String(annotation.coordinate.latitude) + String(annotation.coordinate.longitude)]!)
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier, type: pointRegister[String(annotation.coordinate.latitude) + String(annotation.coordinate.longitude)]!)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView!.backgroundColor = .clear
            }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
}


class CustomAnnotationView: MGLAnnotationView {
    
    let imageView = UIImageView()
    init(reuseIdentifier: String?, type: AnyClass) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image(forClass: type)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scalesWithViewingDistance = true
        imageView.setNeedsDisplay()
    }
    
    func image(forClass type: AnyClass) -> UIImage {
        switch String(describing: type.self) {
            case String(describing: ArtFacility.self):
                return #imageLiteral(resourceName: "art")
            case String(describing: ArtItem.self):
                return #imageLiteral(resourceName: "art")
            case String(describing: DrinkingFountain.self):
                return #imageLiteral(resourceName: "water")
            case String(describing: DogPark.self):
                return #imageLiteral(resourceName: "dog")
            case String(describing: FitnessSite.self):
                return #imageLiteral(resourceName: "fitness")
            case String(describing: Barbeque.self):
                return #imageLiteral(resourceName: "barbeque")
            case String(describing: Furniture.self):
                return #imageLiteral(resourceName: "bench")
            case String(describing: Toilet.self):
                return #imageLiteral(resourceName: "toilet")
            case String(describing: Playground.self):
                return #imageLiteral(resourceName: "playground")
            default:
                fatalError("No image for class: \(String(describing: type.self))")
        }
        return UIImage()
    }
}

