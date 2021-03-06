//
//  CoinImageViewModel.swift
//  CryptoNews
//
//  Created by Bi on 17/04/2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] returnedImage in
            self?.image = returnedImage
        }
        .store(in: &cancellables)
    }
}
