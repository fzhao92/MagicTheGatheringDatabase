//
//  MagicTheGatheringRouter.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/5/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import Alamofire

enum MagicTheGatheringRouter: URLRequestConvertible {
    
    static let baseURL = "https://api.magicthegathering.io/v1/cards"
    
    case allCards(page: Int)
    case specificCard(id: String)
    case searchCards(searchQuery: String, page: Int)
    
    var method:     HTTPMethod {
        switch self {
        case .allCards, .specificCard, .searchCards:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .allCards, .searchCards:
            return ""
        case .specificCard(let id):
            return "/" + id
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .allCards(let page):
                return ["pageSize": 15, "page": page]
            case .specificCard:
                return [:]
            case .searchCards(let cardName, let page):
                return ["name": cardName, "pageSize": 15, "page": page]
            }
        }()
        
        let url = try MagicTheGatheringRouter.baseURL.asURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }

}
