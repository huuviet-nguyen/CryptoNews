//
//  CryptoNewsApp.swift
//  CryptoNews
//
//  Created by Bi on 10/04/2022.
//

import SwiftUI

@main
struct CryptoNewsApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
