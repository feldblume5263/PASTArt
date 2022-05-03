//
//  ContentView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import SwiftUI

struct CookingConfigAndGuideView: View {
    @EnvironmentObject var store: AppStore
    // 파스타 타입을 시작 버튼을 누를 때 받아와야 함
    var typeOfPasta: Pasta = .pomodoro
    
    var body: some View {
        Group {
            switch store.state.currentStage {
            case .settingConfig:
                PreconfigurationView()
                    .environmentObject(store)
            default:
                CookingGuideView(typeOfPasta: typeOfPasta)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        CookingConfigAndGuideView(typeOfPasta: .pomodoro)
            .environmentObject(store)
    }
}
