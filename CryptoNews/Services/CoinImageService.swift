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
        Task {
            await getCoinImage()
        }
        
    }
    
    private func getCoinImage() async {
        guard let url = URL(string: coin.image) else { return }
        
        do {
            let data = try await NetworkingMananger.download(url: url)
            self.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}
