//
//  HomeViewModel.swift
//  CryptoNews
//
//  Created by Bi on 10/04/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins.sink { [weak self] coins in
            self?.allCoins = coins
        }
        .store(in: &cancellables)
    }
}
