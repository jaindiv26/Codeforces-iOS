//
//  CustomSectionView.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 08/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class CustomSectionView: UICollectionReusableView {
    
    let label = UILabel.init(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground

        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setHeaderText(text: String) {
        label.text = text
    }
}
