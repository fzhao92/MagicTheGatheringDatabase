//
//  Card.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Rarity {
    case NotValuable
    case Rare
    case MythicRare
}

struct Card {
    let name: String
    let rarity: Rarity
    let setName: String
    let flavor: String
    let artist: String
    let type: String
    let imageUrl: URL?
    var image: UIImage?
    
    init(dict: JSON) {
        name = dict["name"].stringValue
        
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
        
        let imageUrlStr = dict["imageUrl"].stringValue
        
        if let url = URL(string: imageUrlStr) {
            imageUrl = url
        }else {
            print("Malformed image url")
            imageUrl = nil
        }
    }
}
