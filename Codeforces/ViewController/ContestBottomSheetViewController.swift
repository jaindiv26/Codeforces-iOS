//
//  ContestBottomSheetViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 08/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

protocol OpenContestWebsite {
    func openContestWebsite(contestId: Int)
}

class ContestBottomSheetViewController: UIViewController {
    
    var delegate: OpenContestWebsite?
    
    private lazy var contestName: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contestWebsite: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Visit contest", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = UIConstants.cornerRadius
        return button
    }()
    
    private var model: GymModel?
    
    init (model: GymModel, delegate: OpenContestWebsite) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        createViews()
        setData()
    }
    
    func createViews() {
        view.addSubview(contestName)
        contestName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.sidePadding).isActive = true
        contestName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.verticalPadding).isActive = true
        contestName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIConstants.sidePadding).isActive = true
        
        contestWebsite.addTarget(self, action:#selector(didTapContestWebsite), for: .touchUpInside)
        view.addSubview(contestWebsite)
        contestWebsite.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: UIConstants.sidePadding).isActive = true
        contestWebsite.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -UIConstants.sidePadding).isActive = true
        contestWebsite.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -UIConstants.verticalPadding).isActive = true
        contestWebsite.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight).isActive = true
    }
    
    @objc func didTapContestWebsite() {
        guard let id = model?.id else {
            return
        }
        delegate?.openContestWebsite(contestId: id)
    }
    
    func setData() {
        contestName.text = model?.name
    }
}
