//
//  ContestModel.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 14/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation

class ContestModel {
    
    var contestId: Int = 0
    var contestName: String = ""
    var contestRank: Int = 0
    var oldRating: Int = 0
    var change: Int = 0
    var newRating: Int = 0
    
    init(
        contestId: Int,
        contestName: String,
        contestRank: Int,
        oldRating: Int,
        change: Int,
        newRating: Int
    ) {
        self.contestId = contestId
        self.contestName = contestName
        self.contestRank = contestRank
        self.oldRating = oldRating
        self.change = change
        self.newRating = newRating
    }
}
