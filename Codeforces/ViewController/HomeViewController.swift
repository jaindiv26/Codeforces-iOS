//
//  HomeViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    ContestListDelegate
{
    
    var viewModel: ContestViewModel?
    var list:  [GymModel] = []
    var currentContestList:  [GymModel] = []
    var pastContestList:  [GymModel] = []
    let flowLayout = UICollectionViewFlowLayout()
    var collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        let safeAreaLayout =  view.safeAreaLayoutGuide
        
        let phoneWidth = CGFloat(self.view.frame.width)
        let cellSize = CGSize(width: phoneWidth , height: 50)
        
        flowLayout.itemSize = cellSize
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize.init(width: phoneWidth, height: 30)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
        flowLayout.minimumLineSpacing = 20
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: safeAreaLayout.layoutFrame.height).isActive = true
        collectionView.register(BaseContestCell.self, forCellWithReuseIdentifier: BaseContestCell.description())
        collectionView.register(CustomSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomSectionView.description())
        collectionView.backgroundColor = .systemBackground
        
        viewModel = ContestViewModel.init(delegate: self)
        viewModel?.getHomeContestList()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return currentContestList.count
        case 1:
            return pastContestList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomSectionView.description(), for: indexPath) as! CustomSectionView
            
            switch indexPath.section {
            case 0:
                headerView.setHeaderText(text: "Current or upcoming contests")
                break
            case 1:
                headerView.setHeaderText(text: "Past contest")
                break
                
            default:
                break
            }
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseContestCell.description(), for: indexPath) as! BaseContestCell
        switch indexPath.section {
        case 0:
            cell.displayContest(contest: currentContestList[indexPath.row])
            break
        case 1:
            cell.displayContest(contest: pastContestList[indexPath.row])
            break
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presentDrawer()
            break
        case 1:
            self.navigationController?.present(WebViewController.init(contestId: pastContestList[indexPath.row].id), animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func presentDrawer() {
        let viewController = ContestBottomSheetViewController()
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true)
    }
    
    
    func getHomeContestList(currentContestList: [GymModel], pastContestList: [GymModel]) {
        self.currentContestList = currentContestList
        self.pastContestList = pastContestList
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getGymContestList(list: [GymModel]) {
        
    }
    
    func getUserContestList(list: [ContestModel]) {
        
    }
    
}

extension HomeViewController: DrawerPresentationControllerDelegate {
    func drawerMovedTo(position: DraweSnapPoint) {
        
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting, blurEffectStyle: .dark)
    }
}
