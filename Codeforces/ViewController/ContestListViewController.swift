//
//  ContestListViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 14/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ContestListViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
ContestListDelegate {
    
    var preferredHandle = ""
    var viewModel: ContestViewModel?
    var list:  [ContestModel] = []
    let flowLayout = UICollectionViewFlowLayout()
    var collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(preferredHandle: String) {
        super.init(nibName: nil, bundle: nil)
        self.preferredHandle = preferredHandle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let phoneWidth = CGFloat(self.view.frame.width)
        let cellSize = CGSize(width: phoneWidth , height: 170)
        
        flowLayout.itemSize = cellSize
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        collectionView.register(ContestCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        
        viewModel = ContestViewModel.init(delegate: self, preferredHandle: preferredHandle)
        viewModel?.loadItems()
    }
    
    func getList(list: [ContestModel]) {
        self.list = list
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContestCell
        cell.displayContest(contest: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(WebViewController.init(contestId: list[indexPath.row].contestId), animated: true)
    }
}
