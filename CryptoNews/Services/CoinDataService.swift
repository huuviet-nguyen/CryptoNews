//
//  CoinDataService.swift
//  CryptoNews
//
//  Created by Bi on 10/04/2022.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        Task {
            await getCoins()
        }
    }
    
    private func getCoins() async {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        do {
            let data = try await NetworkingMananger.download(url: url)
            allCoins = try JSONDecoder().decode([CoinModel].self, from: data)
        } catch {
            print(error)
        }
    }
}
