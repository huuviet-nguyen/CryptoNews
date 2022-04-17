//
//  CoinImageService.swift
//  CryptoNews
//
//  Created by Bi on 17/04/2022.
//

import Foundation
import UIKit
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingMananger.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingMananger.handlerCompletion, receiveValue: { [weak self] returnImage in
                self?.image = returnImage
                self?.imageSubscription?.cancel()
            })
    }
}
