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
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
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
        guard let unwrappedDataSource = dataSource else {
            fatalError("Datasource is nil")
        }
        let card = unwrappedDataSource.cards[indexPath.row]
        APIClient.downloadImage(url: card.imageUrl) { (image) in
            DispatchQueue.main.async {
                let cardIndex = unwrappedDataSource.cards.index(of: card)!
                let cardIndexPath = IndexPath(row: cardIndex, section: 0)
                if let cell = self.collectionView?.cellForItem(at: cardIndexPath) as? CardCollectionViewCell {
                    cell.updateWithImage(image: image)
                } else {
                    print("There was an issue getting expected cell from view")
                }
            }
        }
    }

}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1.0)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
