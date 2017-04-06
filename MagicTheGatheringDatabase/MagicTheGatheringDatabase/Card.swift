//
//  Card.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

enum Rarity {
    case Uncommon
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
    let imageUrl: String
}
