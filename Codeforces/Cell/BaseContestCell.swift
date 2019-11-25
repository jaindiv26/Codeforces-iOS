//
//  HomeContestCell.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class BaseContestCell: UICollectionViewCell {
    
    let contestName = UILabel.init(frame: CGRect.zero)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let cardView = CardView.init(frame: CGRect.zero)
        contentView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.sidePadding).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contestName.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestName)
        contestName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestName.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: 0).isActive = true
        contestName.font = UIFont(name: "Verdana", size: 14)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contestName.text = nil
    }
    
    func displayContest(contest: GymModel) {
        contestName.text = contest.name
    }
    
}
