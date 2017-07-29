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
        
        
        let realm = try! Realm()
        let toilets = realm.objects(Toilet.self)
        var pointAnnotations = [MGLPointAnnotation]()
        for t in toilets {
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(t.lat), longitude: CLLocationDegrees(t.lon))
            point.title = "toilet"
            pointAnnotations.append(point)
        }
        print(pointAnnotations)
        map.addAnnotations(pointAnnotations)
        
    }
    
    func commenceRouteDrawing() {
        mapView?.showsUserLocation = true
        let helper = DirectionsHelpers.init()
        let point1 = Waypoint(coordinate: CLLocationCoordinate2D(latitude: -35.274452, longitude: 149.098478))
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        LocationManager.requestAlwaysAuthorization()
        LocationManager.startUpdatingLocation()
        
//        let realm = try! Realm()
//        let artFacilities = realm.objects(ArtFacility.self)
//        let artItems = realm.objects(ArtItem.self)
//        let drinkingFountains = realm.objects(DrinkingFountain.self)
//        let dogParks = realm.objects(DogPark.self)
//        let finessSites = realm.objects(FitnessSites.self)
//        let bbqs = realm.objects(Barbeque.self)
//        let furniture = realm.objects(Furniture.self)
//        let toilets = realm.objects(Toilet.self)
//        
//        for f in furniture {
//            let annotation = MGLPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(f.lat), longitude: CLLocationDegrees(f.lon))
//            annotation.title = "Public Furniture"
//            annotation.subtitle = f.type
//            mapView!.addAnnotation(annotation)
//        }
    }
    
    @objc func walkaboutButtonTapped(sender:UIButton!) {
        
        // Setup completion handler for setUpViewController
        let completionHandler:(SetupViewController)->Void = { childVC in
            
            // Call whatever the fuck you want here
            
            self.commenceRouteDrawing()
            
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
        let reuseIdentifier = "Furniture"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier, type: DogPark.self)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView!.backgroundColor = .clear
            }
        
        return annotationView
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

