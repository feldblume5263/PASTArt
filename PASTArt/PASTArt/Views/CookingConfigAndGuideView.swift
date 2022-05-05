//
//  ContentView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import SwiftUI

struct CookingConfigAndGuideView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode
    let pastaInfo: PastaInfo
    var RecipeCards: [RecipeCard] {
        RecipeCard.getRecipesOfPasta(pasta: typeOfPasta)
    }
    
    var typeOfPasta: Pasta
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack {
                    if store.state.currentStage != .showingDetail {
                        HStack {
                            Spacer()
                            Button {
                                store.dispatch(.initConfigAndTimer)
                                RecipeCards.forEach { recipeCard in
                                    recipeCard.isRemoved()
                                }
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                                    .opacity(0.8)
                                    .padding(.horizontal)
                                    .padding(.bottom, store.state.currentStage == .settingConfig ? -20 : 0)
                            }
                        }
                    }
                    switch store.state.currentStage {
                    case .showingDetail:
                        PastaDetailView(pastaInfo: pastaInfo, geometry: geometry)
                    case .settingConfig:
                        PreconfigurationView()
                            .environmentObject(store)
                    case .cookingPasta:
                        CookingGuideView(typeOfPasta: pastaInfo.pasta, pastaInfo: pastaInfo, RecipeCards: RecipeCards)
                            .environmentObject(store)
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let store = AppStore(initialState: .init(), reducer: appReducer)
//        CookingConfigAndGuideView(typeOfPasta: .pomodoro)
//            .environmentObject(store)
//    }
//}
