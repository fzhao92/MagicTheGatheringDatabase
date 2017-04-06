//
//  CardCellViewModel.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class CardCellViewModel {
    
    let name: String
    let rarity: String
    var image: UIImage?
    var backGroundColor: UIColor
    
    init(card: Card) {
        name = card.name
        switch card.rarity {
        case .MythicRare:
            rarity = Rarity.MythicRare.rawValue
            backGroundColor = Colors.mythic
        case .Rare:
            rarity = Rarity.Rare.rawValue
            backGroundColor = Colors.rare
        default:
            rarity = Rarity.NotValuable.rawValue
            backGroundColor = Colors.normal
        }
    }
    
}
