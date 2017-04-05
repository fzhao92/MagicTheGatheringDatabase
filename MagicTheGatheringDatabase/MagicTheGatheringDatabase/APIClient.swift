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
    
    func getAllCards(completion: (JSON) -> Void) {
        Alamofire.request(MagicTheGatheringRouter.allCards).responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Error while fetching all cards")
            }
        }
    }
}
