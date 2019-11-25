//
//  Constants.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let userContestList = "https://codeforces.com/api/user.rating?handle="
    static let homeContestList = "https://codeforces.com/api/contest.list?gym=false"
    static let gymContestList = "https://codeforces.com/api/contest.list?gym=true"
    

}

struct UIConstants {
    public static let sidePadding: CGFloat = 12
    public static let verticalPadding: CGFloat = 12
    public static let betweenPadding: CGFloat = 4
    public static let buttonHeight: CGFloat = 44
    public static let cornerRadius: CGFloat = 8
    public static let iconSize: CGSize = .init(width: 24, height: 24)
    
    enum Image: String {
        case home = "home"
        case gym = "list"
        case profile = "user"
    }
}
