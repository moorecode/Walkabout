//
//  DrinkingFountain.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import RealmSwift
// API URL: https://www.data.act.gov.au/resource/b9vw-nui5.json
class DrinkingFountain: Object {
    @objc dynamic var lat: Float = 0.0
    @objc dynamic var lon: Float = 0.0
}
