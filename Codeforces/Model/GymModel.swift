//
//  GymModel.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation

class GymModel {
    
    var id: Int = 0
    var name: String = ""
    var type: String = ""
    var phase: String = ""
    var frozen: Bool = false
    var durationSeconds: Int = 0
    var startTimeSeconds: Int = 0
    var relativeTimeSeconds: Int = 0
    var preparedBy: String = ""
    var difficulty: Int = 0
    var kind: String = ""
    var country: String = ""
    var city: String = ""
    var season: String = ""
    
    init (
        id: Int,
        name: String,
        type: String,
        phase: String,
        frozen: Bool,
        durationSeconds: Int,
        relativeTimeSeconds: Int,
        startTimeSeconds: Int
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.phase = phase
        self.frozen = frozen
        self.durationSeconds = durationSeconds
        self.relativeTimeSeconds = relativeTimeSeconds
        self.startTimeSeconds = startTimeSeconds
    }
    
    init (
        id: Int,
        name: String,
        type: String,
        phase: String,
        frozen: Bool,
        durationSeconds: Int,
        relativeTimeSeconds: Int,
        startTimeSeconds: Int,
        preparedBy: String,
        difficulty: Int,
        kind: String,
        country: String,
        city: String,
        season: String
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.phase = phase
        self.frozen = frozen
        self.durationSeconds = durationSeconds
        self.relativeTimeSeconds = relativeTimeSeconds
        self.startTimeSeconds = startTimeSeconds
        self.preparedBy = preparedBy
        self.difficulty = difficulty
        self.kind = kind
        self.country = country
        self.city = city
        self.season = season
    }
    
}
