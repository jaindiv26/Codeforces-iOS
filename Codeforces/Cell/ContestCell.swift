//
//  ContestCell.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 14/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class ContestCell: UICollectionViewCell {
    
    let contestName = UILabel.init(frame: CGRect.zero)
    let contestRank = UILabel.init(frame: CGRect.zero)
    let contestOldRating = UILabel.init(frame: CGRect.zero)
    let contestChange = UILabel.init(frame: CGRect.zero)
    let contestNewRating = UILabel.init(frame: CGRect.zero)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cardView = CardView.init(frame: CGRect.zero)
        contentView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.sidePadding).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.verticalPadding).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.verticalPadding).isActive = true
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7

        let codeforcesLogo = UIImageView.init(frame: CGRect.zero)
        codeforcesLogo.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(codeforcesLogo)
        codeforcesLogo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.sidePadding).isActive = true
        codeforcesLogo.topAnchor.constraint(equalTo: cardView.topAnchor, constant: UIConstants.verticalPadding).isActive = true
        codeforcesLogo.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -UIConstants.verticalPadding).isActive = true
        codeforcesLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        codeforcesLogo.image = UIImage(named: "codeforces_logo")
        
        contestName.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestName)
        contestName.leadingAnchor.constraint(equalTo: codeforcesLogo.trailingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: UIConstants.verticalPadding).isActive = true
        contestName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        contestRank.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestRank)
        contestRank.leadingAnchor.constraint(equalTo: codeforcesLogo.trailingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestRank.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestRank.topAnchor.constraint(equalTo: contestName.bottomAnchor, constant: UIConstants.verticalPadding).isActive = true
        contestRank.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        contestOldRating.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestOldRating)
        contestOldRating.leadingAnchor.constraint(equalTo: codeforcesLogo.trailingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestOldRating.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestOldRating.topAnchor.constraint(equalTo: contestRank.bottomAnchor, constant: UIConstants.betweenPadding).isActive = true
        contestOldRating.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        contestChange.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestChange)
        contestChange.leadingAnchor.constraint(equalTo: codeforcesLogo.trailingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestChange.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestChange.topAnchor.constraint(equalTo: contestOldRating.bottomAnchor, constant: UIConstants.betweenPadding).isActive = true
        contestChange.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        contestNewRating.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contestNewRating)
        contestNewRating.leadingAnchor.constraint(equalTo: codeforcesLogo.trailingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestNewRating.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        contestNewRating.topAnchor.constraint(equalTo: contestChange.bottomAnchor, constant: UIConstants.betweenPadding).isActive = true
        contestNewRating.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func displayContest(contest: ContestModel) {
        contestName.text = contest.contestName
        contestRank.text = "Rank • " + String(contest.contestRank)
        contestOldRating.text = "Old Rating • " + String(contest.oldRating)
        contestChange.text = "Change • " + String(contest.change)
        contestNewRating.text = "New Rating • " + String(contest.newRating)
    }
}
