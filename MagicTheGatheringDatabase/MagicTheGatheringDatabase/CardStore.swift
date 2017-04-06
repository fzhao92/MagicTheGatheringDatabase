//
//  CardStore.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class CardStore {
    
    var cards: [Card] = [Card]()
    
    func getCards(page: Int) {
        APIClient.getAllCards(page: page) { (response) in
            
        }
    }
}
