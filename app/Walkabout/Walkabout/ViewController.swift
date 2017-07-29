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

class ViewController: UIViewController {
    
    let walkaboutButton = PressableButton()
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
//        let artFacilities = realm.objects(ArtFacility.self)
//        let artItems = realm.objects(ArtItem.self)
//        let drinkingFountains = realm.objects(DrinkingFountain.self)
//        let dogParks = realm.objects(DogPark.self)
//        let finessSites = realm.objects(FitnessSites.self)
//        let bbqs = realm.objects(Barbeque.self)
        let furniture = realm.objects(Furniture.self)
//        let toilets = realm.objects(Toilet.self)
        
        for f in furniture {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: 45.5076, longitude: -122.6736)
            annotation.title = "Public Furniture"
            annotation.subtitle = f.type
            mapView.addAnnotation(annotation)
        }
        
        
    }
    
    @objc func walkaboutButtonTapped(sender:UIButton!) {
        
        let setupView = SetupViewController()
        setupView.preferredContentSize = CGSize(width: 300, height: 400)
        setupView.modalPresentationStyle = .popover
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
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
}


