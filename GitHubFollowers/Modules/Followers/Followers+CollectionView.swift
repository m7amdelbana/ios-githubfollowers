//
//  Followers+CollectionView.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension FollowersController: UICollectionViewDelegate {
    
    func configureCollectionView() {
        let flowLayout = GridFlowLayout(width: view.bounds.width, columns: 3)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.id)
        collectionView.delegate = self
    }
    
    func configurDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionSection, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.id, for: indexPath) as! FollowerCell
            cell.setupCell(follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        snapshot = NSDiffableDataSourceSnapshot<CollectionSection, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if paginate.isMoreData && !paginate.isLoading && (offsetY > contentHeight - height) {
            paginate.page += 1
            getFollowers(username: username, paginate: paginate)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = filteredFollowers.isEmpty ? followers[indexPath.item] : filteredFollowers[indexPath.item]
        presentFollower(with: follower.login)
    }
}
