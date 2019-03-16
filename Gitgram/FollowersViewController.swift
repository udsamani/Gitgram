//
//  ViewController.swift
//  Gitgram
//
//  Created by Udit Samani on 3/14/19.
//  Copyright © 2019 Udit Samani. All rights reserved.
//

import UIKit

class FollowersViewController: UICollectionViewController {

    private var followers : [Follower] = []
    private var flowLayout = ColumnFlowLayout()
    
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(followers)
        return followers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifer, for: indexPath)
            as? FollowerCell else { preconditionFailure("Failed to load follower cell data.")}
        cell.follower = followers[indexPath.item]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        getFollowers()
    }
    
    func prepareCollectionView() {
        
        guard let navController = self.navigationController else { return }
        
        self.title = "Followers"
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.barTintColor = UIColor.appBackgroundColor
        navController.navigationBar.shadowImage = #imageLiteral(resourceName: "barShadow")
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        //TO DO - Define Avatar View()
        let avatarView = AvatarView()
        let leftBarBUttonItem = UIBarButtonItem(customView: avatarView)
        self.navigationItem.leftBarButtonItem = leftBarBUttonItem
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.appBackgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white
        

    }
    
    func getFollowers()  {
        let queryService = QueryService()
        queryService.getFollowerQueryResults(queryItem: "ankitgohel1996") { (results, errorMessage) in
            if let results = results {
                self.followers = results
                print(self.followers)
                self.collectionView.reloadData()
            }
        }
    }


}

