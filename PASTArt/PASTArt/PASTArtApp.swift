//
//  PASTArtApp.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import SwiftUI

@main
struct PASTArtApp: App {
    let store = AppStore(initialState: .init(), reducer: appReducer)
    
    var body: some Scene {
        WindowGroup {
            PastaLibraryView()
                .environmentObject(store)
//            CookingConfigAndGuideView()
//                .environmentObject(store)
        }
    }
}
