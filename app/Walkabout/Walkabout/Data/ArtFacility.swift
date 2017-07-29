//
//  ArtFacility.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import RealmSwift
// API URL: https://www.data.act.gov.au/resource/n2d8-bhdk.json
class ArtFacility: Object {
    
    @objc dynamic var address = ""
    @objc dynamic var name = ""
    @objc dynamic var lat: Float = 0.0
    @objc dynamic var lon: Float = 0.0
    @objc dynamic var url = ""
}
