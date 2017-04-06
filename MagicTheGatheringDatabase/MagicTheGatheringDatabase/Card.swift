//
//  Card.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Rarity: String {
    case NotValuable = "Common"
    case Rare = "Rare"
    case MythicRare = "Mythic Rare"
}

struct Card {
    let name: String
    let id: String
    let rarity: Rarity
    let setName: String
    let flavor: String
    let artist: String
    let type: String
    let imageUrl: String
    var image: UIImage?
    
    init(dict: JSON) {
        name = dict["name"].stringValue
        id = dict["id"].stringValue
        let rarityStr = dict["rarity"].stringValue
        
        switch rarityStr {
        case "Rare":
            rarity = .Rare
        case "Mythic Rare":
            rarity = .MythicRare
        default:
            rarity = .NotValuable
        }
        
        setName = dict["setName"].stringValue
        flavor = dict["flavor"].stringValue
        artist = dict["artist"].stringValue
        type = dict["type"].stringValue
        imageUrl = dict["imageUrl"].stringValue
    }
}

extension Card: Equatable { }

func == (lhs: Card, rhs: Card) -> Bool {
    return lhs.id == rhs.id
}
