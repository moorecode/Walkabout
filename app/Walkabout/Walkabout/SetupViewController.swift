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

class SetupViewController: UIViewController {
    
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
        dogButton.setTitle("Doggo", for: .normal)
        let playgroundButton = FlatButton()
        playgroundButton.setTitle("Playgrounds", for: .normal)
        let artButton = FlatButton()
        artButton.setTitle("Art", for: .normal)
        let benchButton = FlatButton()
        benchButton.setTitle("Benches", for: .normal)
        let fountainButton = FlatButton()
        fountainButton.setTitle("Fountain", for: .normal)
        let toiletButton = FlatButton()
        toiletButton.setTitle("Toilet", for: .normal)
        let fitnessButton = FlatButton()
        fitnessButton.setTitle("Fitness", for: .normal)
        let barbequeButton = FlatButton()
        barbequeButton.setTitle("Barbeque", for: .normal)
        
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
        
        
        // Add the start button
        view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Archive", size: 26)
        startButton.colors = .init(button: UIColor.flatOrange(), shadow: UIColor.flatOrangeColorDark())
        startButton.addTarget(self, action: #selector(close), for: .touchUpInside)
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
            make.left.equalTo(view.snp.leftMargin)
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
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
