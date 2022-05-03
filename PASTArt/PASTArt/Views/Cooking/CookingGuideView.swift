//
//  CookingGuideView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookingGuideView: View {
    
    @EnvironmentObject var store: AppStore
    var typeOfPasta: Pasta
    
    var noodleDuration: TimeInterval? {
        store.state.config.typeOfNoodle?.cookDuration[store.state.config.cookingLevel ?? .aldente]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                CookTimers(geometry: geometry)
                CookingGuideCarousel(typeOfPasta: typeOfPasta, geometry: geometry)
                Spacer()
            }
        }
    }
}

struct CookingGuideView_Previews: PreviewProvider {
    
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        CookingGuideView(typeOfPasta: .pomodoro)
            .environmentObject(store)
    }
}
