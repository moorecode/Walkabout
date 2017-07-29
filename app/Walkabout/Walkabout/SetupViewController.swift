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
        // Do any additional setup after loading the view.
        
        // Add the close button
        view.addSubview(closeButton)
        closeButton.setTitle("Back", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Archive", size: 26)
        closeButton.colors = .init(button: UIColor.flatWatermelon(), shadow: UIColor.flatWatermelonColorDark())
        closeButton.shadowHeight = 10
        closeButton.cornerRadius = 8
        closeButton.depth = 3
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.left.equalTo(view.snp.leftMargin)
            make.width.equalTo(view.snp.width).dividedBy(4)
        }
        
        // Add the start button
        view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Archive", size: 26)
        startButton.colors = .init(button: UIColor.flatGreen(), shadow: UIColor.flatGreenColorDark())
        startButton.shadowHeight = 10
        startButton.cornerRadius = 8
        startButton.depth = 3
        startButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        startButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.left.equalTo(closeButton.snp.rightMargin).offset(16)
        }
    }
    
    @objc func close() {
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
