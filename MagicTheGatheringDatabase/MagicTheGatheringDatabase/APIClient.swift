//
//  APIClient.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIClient {
    
    static func getAllCards(page: Int, completion: @escaping ([Card]) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.allCards(page: page)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonArray = json["cards"].arrayValue
                var cards = [Card]()
                for dict in jsonArray {
                    cards.append(Card(dict: dict))
                }
                completion(cards)
            case .failure(let error):
                print("Error getting json response: \(error)")
                completion([Card]())
            }
        }
    }
    
    static func getCardByID(id: String, completion: @escaping (Card) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.specificCard(id: id))
        .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let dict = JSON(value)
                completion(Card(dict: dict))
            case .failure(let error):
                print("Error getting json response: \(error)")
            }
        }
    }
    
    static func searchForCard(query: String, page: Int, completion: @escaping ([Card]) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.searchCards(searchQuery: query, page: page))
        .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonArray = json["cards"].arrayValue
                var cards = [Card]()
                for dict in jsonArray {
                    cards.append(Card(dict: dict))
                }
                completion(cards)
            case .failure(let error):
                print("Error getting json response: \(error)")
                completion([Card]())
            }
        }
    }
    
}
