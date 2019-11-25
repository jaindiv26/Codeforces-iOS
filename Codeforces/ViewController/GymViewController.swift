//
//  GymViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class GymViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    ContestListDelegate
{
    var viewModel: ContestViewModel?
    var list:  [GymModel] = []
    let flowLayout = UICollectionViewFlowLayout()
    var collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
        collectionView.register(BaseContestCell.self, forCellWithReuseIdentifier: BaseContestCell.description())
        collectionView.backgroundColor = .systemBackground
        
        viewModel = ContestViewModel.init(delegate: self)
        viewModel?.getGymContestList()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseContestCell.description(), for: indexPath) as! BaseContestCell
        cell.displayContest(contest: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(WebViewController.init(contestId: list[indexPath.row].id), animated: true)
    }
    
    func getHomeContestList(currentContestList: [GymModel], pastContestList: [GymModel]) {
        
    }
    
    func getGymContestList(list: [GymModel]) {
        self.list = list
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getUserContestList(list: [ContestModel]) {
        
    }
    
}
