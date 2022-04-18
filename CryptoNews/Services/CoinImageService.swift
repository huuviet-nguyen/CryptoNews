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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    init(coin: CoinModel) {
        self.coin = coin
        Task {
            await getCoinImage()
        }
        
    }
    
    func getCoinImage() async {
        if let savedImage = fileManager.getImage(
            imageName: coin.id,
            folderName: folderName
        ) {
            self.image = savedImage
            return
        }
        await downloadCoinImage()
    }
    
    private func downloadCoinImage() async {
        guard let url = URL(string: coin.image) else { return }
        
        do {
            let data = try await NetworkingMananger.download(url: url)
            guard let image = UIImage(data: data) else { return }
            self.image = image
            self.fileManager.saveImage(
                image: image,
                imageName: coin.id,
                folderName: folderName
            )
        } catch {
            print(error)
        }
    }
}
