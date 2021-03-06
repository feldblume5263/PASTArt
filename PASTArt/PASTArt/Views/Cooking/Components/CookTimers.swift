//
//  CookTimers.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/03.
//

import SwiftUI
import Combine

struct CookTimers: View {
    @EnvironmentObject var store: AppStore
    private let timePublisher = Timer.publish(every: 0.1, tolerance: 0.01, on: .main, in: .common).autoconnect()
    let geometry: GeometryProxy
    var RecipeCards: [RecipeCard]
    
    var body: some View {
        HStack {
            ForEach(store.state.timers, id: \.self.id) { timer in
                Spacer()
                VStack {
                    Text(timer.title ?? " ").lineLimit(1).font(.body.bold()).frame(width: geometry.size.width * 0.25)
                    CookTimer(timePublisher: timePublisher, geometry: geometry, timer: timer, RecipeCards: RecipeCards)
                    Text(Store<Any, Any>.getTimeString(count: timer.currentCount, duration: timer.duration, addSymbol: true)).font(.body.bold())
                }
                Spacer()
            }
        }
    }
}

struct CookTimer: View {
    @EnvironmentObject var store: AppStore
    let timePublisher: Publishers.Autoconnect<Timer.TimerPublisher>
    
    let geometry: GeometryProxy
    var timer: TimerConfig
    let lineWidth: CGFloat = 10
    var RecipeCards: [RecipeCard]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(timer.currentCount) / Float(timer.duration), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: timer.currentCount)
            if timer.isOccupied {
                Image(systemName: timer.isRunning ? "pause.fill" : "play.fill").foregroundColor(.black)
            }
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if store.state.timers[timer.id].isOccupied {
                        store.dispatch(.toggleTimer(timer.id))
                    }
                }
        }
        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
        .onReceive(timePublisher) { _ in
            if store.state.timers[timer.id].isOccupied && store.state.timers[timer.id].isRunning {
                store.dispatch(.countTime(timer.id))
            }
        }
    }
}

struct CookTimers_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        let RecipeCards: [RecipeCard] = RecipeCard.getRecipesOfPasta(pasta: .pomodoro)
        
        GeometryReader { geometry in
            CookTimers(geometry: geometry, RecipeCards: RecipeCards)
                .environmentObject(store)
        }
    }
}
