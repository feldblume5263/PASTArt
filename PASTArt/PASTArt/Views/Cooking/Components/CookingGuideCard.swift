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
    var step: RecipeCard
    let geometry: GeometryProxy
    let cookingVideo = AVPlayer(url: Bundle.main.url(forResource: "fryingOnion", withExtension: "mp4") ?? URL(fileURLWithPath: ""))
    let isFinalCard: Bool
    
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
                    VideoPlayer(player: cookingVideo)
                        .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fit)
                        .frame(width: geometry.size.height * 0.35)
                    Text("\(step.description)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(height: geometry.size.height * 0.2, alignment: .top)
                }
                .padding(.top, geometry.size.height * 0.05)
                
                if step.duration != nil || step.isNoodle {
                    if !step.isCounting {
                        VStack {
                            if let duration = step.duration {
                                Text("\(duration)")
                            } else if step.isNoodle {
                                Text("\(store.state.config.typeOfNoodle?.cookDuration[store.state.config.cookingLevel ?? .aldente] ?? 0)")
                            }
                            Button {
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
                                    HStack {
                                        Text("타이머 시작").font(.body.bold())
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.bottom, geometry.size.height * 0.05)
                        .frame(height: geometry.size.height * 0.15)
                    } else {
                        
                        
                    }
                } else {
                    Button {
                        if !isFinalCard {
                            store.dispatch(.turnPageForward)
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

struct CookingGuideCard_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        GeometryReader { geometry in
            CookingGuideCard(step: RecipeCard.getRecipesOfPasta(pasta: .pomodoro)[3], geometry: geometry, isFinalCard: false)
                .environmentObject(store)
        }
    }
}
