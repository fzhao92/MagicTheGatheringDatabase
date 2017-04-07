//
//  CardsCollectionViewController.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cardCell"

protocol RefreshCardsProtocol: class {
    var isLoadingCards: Bool { get }
    func fetchCards()
}

class CardsCollectionViewController: UICollectionViewController {

    var dataSource: CardDataSource?
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate var pageNumber = 1
    var isLoadingCards = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.dataSource = dataSource
        self.collectionView!.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        dataSource!.delegate = self
        fetchCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let card = dataSource!.cards[indexPath.row]
        APIClient.downloadImage(url: card.imageUrl) { (image) in
            DispatchQueue.main.async {
                let cardIndex = self.dataSource!.cards.index(of: card)!
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

extension CardsCollectionViewController: RefreshCardsProtocol {
    
    func fetchCards() {
        isLoadingCards = true
        APIClient.getAllCards(page: pageNumber) { (cards) in
            if let unwrappedDataSource = self.dataSource {
                unwrappedDataSource.cards += cards
                self.isLoadingCards = false
                self.pageNumber += 1
                self.collectionView!.reloadSections(IndexSet(integer: 0))
            } else {
                print("DataSource is nil")
            }
        }
    }
    
}
