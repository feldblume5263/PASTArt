//
//  ContentView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        Group {
            if store.state.currentStage == .settingConfig {
                PreconfigurationView()
                    .environmentObject(store)
            } else {
                CookingGuideView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        ContentView()
            .environmentObject(store)
    }
}
