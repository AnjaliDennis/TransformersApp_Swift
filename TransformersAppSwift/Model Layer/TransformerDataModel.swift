//
//  TransformerDataModel.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 06/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import Foundation
import UIKit

class TransformerDataModel: Codable {
    var id: String?
    var name: String?
    var strength: String?
    var intelligence: String?
    var speed: String?
    var endurance: String?
    var rank: String?
    var courage: String?
    var firepower: String?
    var skill: String?
    var team: String?
    var team_icon: String?
    var rating: String?
    var battleOutcome: String?
}

class TransformerDataModelArray: Codable {
    var transformers: [TransformerDataModel]?
}
