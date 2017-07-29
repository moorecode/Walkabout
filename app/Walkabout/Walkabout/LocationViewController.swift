//
//  LocationViewController.swift
//  Walkabout
//
//  Created by Sam Moore on 30/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import SwiftyButton
import SnapKit

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let hello = UILabel()
        hello.minimumScaleFactor = 0.4
        hello.adjustsFontSizeToFitWidth = true
        let hour = Calendar.current.dateComponents([.hour], from: Date())
        
        if hour.hour! < 8 {
            hello.text = "Early Morning"
        }
        else if hour.hour! < 11 {
            hello.text = "Late Morning"
        }
        else if hour.hour! < 15 {
            hello.text = "Early Afternoon"
        }
        else if hour.hour! < 17 {
            hello.text = "Afternoon"
        }
        else if hour.hour! < 20 {
            hello.text = "Evening"
        }
        else {
            hello.text = "Night"
        }
        
        hello.text = hello.text! + " Walkabout Location"
        hello.minimumScaleFactor = 0.5
        
        hello.font = UIFont(name: "Archive", size: 24)
        hello.textAlignment = .center
        hello.textColor = UIColor.flatGray()
        view.addSubview(hello)
        hello.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(8)
            make.right.equalTo(view.snp.rightMargin)
            make.left.equalTo(view.snp.leftMargin)
        }
        
        let startLabel = UILabel()
        startLabel.font = UIFont(name: "Archive", size: 20)
        startLabel.text = "Starting Point"
        view.addSubview(startLabel)
        startLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hello.snp.bottomMargin).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let startLocButton = FlatButton()
        startLocButton.color = UIColor.flatPurple()
        startLocButton.titleLabel?.font = UIFont(name: "Archive", size: 20)
        startLocButton.setTitle("🚩 Current Location", for: .normal)
        startLocButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        view.addSubview(startLocButton)
        startLocButton.snp.makeConstraints { (make) in
            make.top.equalTo(startLabel.snp.bottomMargin).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let destinationLabel = UILabel()
        destinationLabel.font = UIFont(name: "Archive", size: 20)
        destinationLabel.text = "Destination"
        view.addSubview(destinationLabel)
        destinationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startLocButton.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let endLocButton = FlatButton()
        endLocButton.color = UIColor.flatPurple()
        endLocButton.titleLabel?.font = UIFont(name: "Archive", size: 20)
        endLocButton.setTitle("🚩 Current Location", for: .normal)
        endLocButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        view.addSubview(endLocButton)
        endLocButton.snp.makeConstraints { (make) in
            make.top.equalTo(destinationLabel.snp.bottomMargin).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let doneButton = PressableButton()
        doneButton.colors = .init(button: UIColor.flatOrange(), shadow: UIColor.flatOrangeColorDark())
        doneButton.titleLabel?.font = UIFont(name: "Archive", size: 24)
        doneButton.setTitle("Done", for: .normal)
        doneButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        doneButton.addTarget(self, action: #selector(bye), for: .touchUpInside)
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(endLocButton.snp.bottomMargin).offset(40)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc func bye() {
        dismiss(animated: true, completion: nil)
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
