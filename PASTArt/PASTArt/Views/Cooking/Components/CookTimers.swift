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
    
    var body: some View {
        HStack {
            ForEach(store.state.timers, id: \.self.id) { timer in
                Spacer()
                VStack {
                    Text(timer.title ?? " ").lineLimit(1).font(.caption.bold()).frame(width: geometry.size.width * 0.25)
                    CookTimer(timePublisher: timePublisher, geometry: geometry, timer: timer)
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
    let timer: TimerConfig
    let lineWidth: CGFloat = 10
    
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
        }
        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
        .onReceive(timePublisher) { _ in
            if store.state.timers[timer.id].isOccupied {
                store.dispatch(.countTime(timer.id))
            }
        }
        
    }
}

struct CookTimers_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        GeometryReader { geometry in
            CookTimers(geometry: geometry)
                .environmentObject(store)
        }
    }
}
