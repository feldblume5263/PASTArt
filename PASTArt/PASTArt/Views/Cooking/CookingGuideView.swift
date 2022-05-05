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
    let pastaInfo: PastaInfo
    
    var noodleDuration: TimeInterval? {
        store.state.config.typeOfNoodle?.cookDuration[store.state.config.cookingLevel ?? .aldente]
    }
    
    var RecipeCards: [RecipeCard]
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                CookTimers(geometry: geometry, RecipeCards: RecipeCards)
                CookingGuideCarousel(typeOfPasta: typeOfPasta, geometry: geometry, pastaInfo: pastaInfo, RecipeCards: RecipeCards)
                Spacer()
            }
        }
    }
}

//struct CookingGuideView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let store = AppStore(initialState: .init(), reducer: appReducer)
//        let RecipeCards = RecipeCard.getRecipesOfPasta(pasta: .pomodoro)
//        CookingGuideView(typeOfPasta: .pomodoro, RecipeCards: RecipeCards)
//            .environmentObject(store)
//    }
//}
