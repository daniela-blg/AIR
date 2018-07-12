//
//  Stock.swift
//  AIR
//
//  Created by Daniela Bulgaru on 12/07/2018.
//  Copyright © 2018 Daniela Bulgaru. All rights reserved.
//

import Foundation

struct Stock {
    let name: String
    let market: String
    let currentPrice: Double
    let maxPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case quote
        case trades
    }
    
    enum QuoteKeys: String, CodingKey {
        case name = "symbol"
        case market = "primaryExchange"
        case currentPrice = "latestPrice"
    }
    
    enum TradesKeys: String, CodingKey {
        case maxPrice = "weekHigh"
    }
}

extension Stock: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let quote = try values.nestedContainer(keyedBy: QuoteKeys.self, forKey: .quote)
        let trades = try values.nestedContainer(keyedBy: TradesKeys.self, forKey: .trades)
        
        name = try quote.decode(String.self, forKey: QuoteKeys.name)
        market = try quote.decode(String.self, forKey: QuoteKeys.market)
        currentPrice = try quote.decode(Double.self, forKey: QuoteKeys.currentPrice)
        
        maxPrice = try trades.decode(Double.self, forKey: TradesKeys.maxPrice)
    }
}



