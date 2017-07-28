//
//  MapItem.swift
//  Walkabout
//
//  Created by Sam Moore on 28/7/17.
//  Copyright © 2017 GovHack. All rights reserved.
//

import UIKit

protocol MapItem {
    var lat: Float {get}
    var long: Float {get}
    var title: String {get}
}
