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
    
    static func getAllCards(page: Int, completion: @escaping (JSON) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.allCards(page: page)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print("Error getting json response: \(error)")
            }
        }
    }
    
    static func getCardByID(id: String, completion: @escaping (JSON) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.specificCard(id: id))
        .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("Specific card json: \(value)")
            case .failure(let error):
                print("Error getting json response: \(error)")
            }
        }
    }
}
