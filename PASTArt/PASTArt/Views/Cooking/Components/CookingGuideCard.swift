//
//  CookingGuideCard.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/03.
//

import SwiftUI
import AVKit

struct CookingGuideCard: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode
    var step: RecipeCard
    let geometry: GeometryProxy
    @State var cookingVideo: AVPlayer?
    let isFinalCard: Bool
    let RecipeCards: [RecipeCard]
    let pastaInfo: PastaInfo?
    
    init(step: RecipeCard, geometry: GeometryProxy, isFinalCard: Bool, RecipeCards: [RecipeCard], pastaInfo: PastaInfo) {
        self.step = step
        self.geometry = geometry
        self.isFinalCard = isFinalCard
        self.RecipeCards = RecipeCards
        self.pastaInfo = pastaInfo
        if let videoName = step.videoName {
            _cookingVideo = State(initialValue: AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "mp4") ?? URL(fileURLWithPath: "")))
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .shadow(color: Color.gray, radius: 5, x: 1, y: 1)
            VStack{
                VStack {
                    Text("\(step.stepName)")
                        .foregroundColor(.gray)
                        .font(.title2.bold())
                        .frame(height: geometry.size.height * 0.05)
                    if step.videoName != nil {
                        VideoPlayer(player: cookingVideo)
                            .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fit)
                            .frame(width: geometry.size.height * 0.35)
                    } else {
                        if let info = pastaInfo {
                            Spacer()
                            ForEach(0 ..< info.ingredient.count, id: \.self) { idx in
                                HStack {
                                    Text(info.ingredient[idx].name)
                                    Spacer()
                                    Text(String(format: "%.0f", info.ingredient[idx].amount * Double(store.state.config.numberOfPeople ?? 1)))
                                    Text(info.ingredient[idx].scale)
                                }
                                .font(.title3).foregroundColor(.gray)
                                .padding(.vertical, 3)
                                .padding(.horizontal)
                            }
                            
                        }
                    }
                    Text("\(step.description)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(height: geometry.size.height * 0.2, alignment: .top)
                }
                .padding(.top, geometry.size.height * 0.05)
                
                
                if step.duration != nil || step.isNoodle { // 타이머가 필요한 카드인 경우
                    // 타이머가 점유 중이고, 재생 중일 때
                    VStack {
                        HStack {
                            Image(systemName: "timer")
                            if let duration = step.duration { // duration이 있는 카드인 경우
                                Text(Store<Any, Any>.getTimeString(count: 0, duration: duration, addSymbol: false))
                            } else if step.isNoodle { // duration이 없지만 noodle인 경우
                                Text(Store<Any, Any>.getTimeString(count: 0, duration: store.state.config.typeOfNoodle?.cookDuration[store.state.config.cookingLevel ?? .aldente] ?? 0, addSymbol: false))
                            }
                        }.font(.body.bold())
                        
                        if let occupyIdx = step.timerOccupy {
                            HStack {
                                Button { // STOP
                                    store.dispatch(.resetTimer(step.timerOccupy ?? 0))
                                    step.isRemoved()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.gray)
                                            .opacity(0.5)
                                            .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                                        Image(systemName: "stop.fill").foregroundColor(.black)
                                    }
                                }
                                Button {
                                    store.dispatch(.toggleTimer(occupyIdx))
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.gray)
                                            .opacity(0.5)
                                            .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                                        Image(systemName: store.state.timers[occupyIdx].isRunning ?  "pause.fill" : "play.fill").foregroundColor(.black)
                                    }
                                }
                            }
                        } else {
                            Button { // PLAY
                                for timerIndex in store.state.timers.indices {
                                    if store.state.timers[timerIndex].isOccupied == false {
                                        if !step.isNoodle {
                                            store.dispatch(.setTimer(timerIndex, step.stepName, step.duration ?? 0))
                                        } else {
                                            store.dispatch(.setTimer(timerIndex, step.stepName, store.state.config.typeOfNoodle?.cookDuration[store.state.config.cookingLevel ?? .aldente] ?? 0))
                                        }
                                        step.isOccupied(by: timerIndex)
                                        return
                                    }
                                }
                                // TODO: - 타이머에 남은 자리가 없다는 알람
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                        .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fit)
                                    Text("타이머 시작").font(.body.bold()).foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding(.bottom, geometry.size.height * 0.05)
                    .frame(height: geometry.size.height * 0.15)
                } else { // 타이머가 필요없는 카드일 경우
                    Button {
                        if !isFinalCard {
                            store.dispatch(.turnPageForward)
                        } else {
                            store.dispatch(.initConfigAndTimer)
                            RecipeCards.forEach { recipeCard in
                                recipeCard.isRemoved()
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fit)
                            HStack {
                                Text(isFinalCard ? "완료" : "다음").font(.body.bold())
                            }
                            .foregroundColor(.black)
                        }
                        .frame(height: geometry.size.height * 0.06)
                        .padding(.bottom, geometry.size.height * 0.05)
                    }
                }
            }
        }
    }
}

//struct CookingGuideCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let store = AppStore(initialState: .init(), reducer: appReducer)
//        let RecipeCards = RecipeCard.getRecipesOfPasta(pasta: .pomodoro)
//        GeometryReader { geometry in
//            CookingGuideCard(step: RecipeCard.getRecipesOfPasta(pasta: .pomodoro)[3], geometry: geometry, isFinalCard: false, RecipeCards: RecipeCards)
//                .environmentObject(store)
//        }
//    }
//}
