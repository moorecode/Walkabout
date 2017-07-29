//
//  SetupViewController.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyButton
import ChameleonFramework
import MapboxDirections
import Mapbox

class SetupViewController: UIViewController {
    
    var completionHandler : ((_ child:SetupViewController) -> Void)?
    
    func dismiss() {
        self.dismiss(animated: true) {
            self.completionHandler?(self)
        }
    }
    
    let closeButton = PressableButton()
    let startButton = PressableButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        let hello = UILabel()
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
        
        hello.text = hello.text! + " Walkabout"
        hello.minimumScaleFactor = 0.5
        
        hello.font = UIFont(name: "Archive", size: 30)
        hello.textAlignment = .center
        hello.textColor = UIColor.flatGray()
        view.addSubview(hello)
        hello.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(8)
            make.right.equalTo(view.snp.rightMargin)
            make.left.equalTo(view.snp.leftMargin)
        }
        
        // Create the stack view with buttons
        let dogButton = FlatButton()
        let dogImage = UIImageView()
        dogImage.image = #imageLiteral(resourceName: "dog")
        dogButton.setTitle("Doggo", for: .normal)
        let playgroundButton = FlatButton()
        let playgroundImage = UIImageView()
        playgroundImage.image = #imageLiteral(resourceName: "playground")
        playgroundButton.setTitle("Playgrounds", for: .normal)
        let artButton = FlatButton()
        let artImage = UIImageView()
        artImage.image = #imageLiteral(resourceName: "art")
        artButton.setTitle("Art", for: .normal)
        let benchButton = FlatButton()
        let benchImage = UIImageView()
        benchImage.image = #imageLiteral(resourceName: "bench")
        benchButton.setTitle("Benches", for: .normal)
        let fountainButton = FlatButton()
        let fountainImage = UIImageView()
        fountainImage.image = #imageLiteral(resourceName: "water")
        fountainButton.setTitle("Fountain", for: .normal)
        let toiletButton = FlatButton()
        let toiletImage = UIImageView()
        toiletImage.image = #imageLiteral(resourceName: "toilet")
        toiletButton.setTitle("Toilet", for: .normal)
        let fitnessButton = FlatButton()
        let fitnessImage = UIImageView()
        fitnessImage.image = #imageLiteral(resourceName: "fitness")
        fitnessButton.setTitle("Fitness", for: .normal)
        let barbequeButton = FlatButton()
        let barbequeImage = UIImageView()
        barbequeImage.image = #imageLiteral(resourceName: "barbeque")
        barbequeButton.setTitle("Barbeque", for: .normal)
        
        let images = [dogImage, playgroundImage, artImage, benchImage, fountainImage, toiletImage, fitnessImage, barbequeImage]
        
        let buttons = [dogButton, playgroundButton, artButton, benchButton, fountainButton, toiletButton, fitnessButton, barbequeButton]
        
        for button in buttons {
            button.color = UIColor.flatGray()
            button.titleLabel?.font = UIFont(name: "Archive", size: 26)
            button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let stackView2 = UIStackView(arrangedSubviews: images)
        stackView2.axis = .vertical
        stackView2.distribution = .fillEqually
        stackView2.alignment = .fill
        stackView2.spacing = 5
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView2)
        
        
        // Add the start button
        view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Archive", size: 26)
        startButton.colors = .init(button: UIColor.flatOrange(), shadow: UIColor.flatOrangeColorDark())
        startButton.addTarget(self, action: #selector(begin), for: .touchUpInside)
        startButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-8)
            make.right.equalTo(view.snp.rightMargin)
            make.left.equalTo(view.snp.leftMargin)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(hello.snp.bottom).offset(8)
            make.bottom.equalTo(startButton.snp.top).offset(-8)
            make.right.equalTo(view.snp.rightMargin)
        }
        
        stackView2.snp.makeConstraints { (make) in
            make.top.equalTo(hello.snp.bottom).offset(8)
            make.bottom.equalTo(startButton.snp.top).offset(-8)
            make.right.equalTo(stackView.snp.left)
            make.left.equalTo(view.snp.left).offset(6)
            make.width.equalTo(stackView.snp.height).dividedBy(8)
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func begin() {
        self.dismiss()
        
    }
    
    @objc func toggle(sender: FlatButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.color = UIColor.flatGreen()
        }
        else {
            sender.color = UIColor.flatGray()
        }
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
