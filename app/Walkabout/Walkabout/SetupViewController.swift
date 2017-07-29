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
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        // Create the stack view
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let dogButton = FlatButton()
        let playgroundButton = FlatButton()
        let artButton = FlatButton()
        let benchButton = FlatButton()
        let fountainButton = FlatButton()
        let toiletButton = FlatButton()
        let fitnessButton = FlatButton()
        let barbequeButton = FlatButton()
        
        let buttons = [dogButton, playgroundButton, artButton, benchButton, fountainButton, toiletButton, fitnessButton, barbequeButton]
        
        for button in buttons {
            button.color = UIColor.flatGray()
            button.titleLabel?.font = UIFont(name: "Archive", size: 26)
            button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        }
        
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
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func toggle(sender: FlatButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.color = UIColor.flatLime()
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
