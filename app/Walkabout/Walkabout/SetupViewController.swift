//
//  SetupViewController.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import SnapKit

class SetupViewController: UIViewController {
    
    let closeButton = UIButton(type: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        view.addSubview(closeButton)
        closeButton.setTitle("close", for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.left.equalTo(view.snp.leftMargin)
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
