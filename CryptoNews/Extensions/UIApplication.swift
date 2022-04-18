//
//  UIApplication.swift
//  CryptoNews
//
//  Created by Bi on 18/04/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
