//
//  CardsCollectionViewController.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cardCell"

class CardsCollectionViewController: UICollectionViewController {

    var dataSource: CardDataSource?
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    fileprivate let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.dataSource = dataSource
        self.collectionView!.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        APIClient.getAllCards(page: 1) { (cards) in
            if let unwrappedDataSource = self.dataSource {
                unwrappedDataSource.cards = cards
                self.collectionView!.reloadSections(IndexSet(integer: 0))
            } else {
                print("DataSource is nil")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //perform image data binding
    }

}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
