//
//  ArtItem.swift
//  Walkabout
//
//  Created by Sam Moore on 29/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit
import RealmSwift

class ArtItem: Object {
    // API URL: https://www.data.act.gov.au/resource/s538-zqvb.json
    @objc dynamic var name = ""
    @objc dynamic var lat: Float = 0.0
    @objc dynamic var lon: Float = 0.0

}
