//
//  CardDataSource.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit


private let reuseIdentifier = "cardCell"

class CardDataSource: NSObject, UICollectionViewDataSource {
    
    var cards: [Card] = [Card]()
    var isLoadingCards = false
    weak var delegate: RefreshCardsProtocol?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CardCollectionViewCell else {
            fatalError("Unexpected indexpath")
        }
        cell.cardCellViewModel = CardCellViewModel(card: cards[indexPath.row])
        let cellsToLoadFromBottom = 6
        let cellsLoaded = cards.count
        
        if !delegate!.isLoadingCards && (indexPath.row >= (cellsLoaded - cellsToLoadFromBottom)) {
            delegate?.fetchCards()
        }
        
        return cell
    }
    
}
