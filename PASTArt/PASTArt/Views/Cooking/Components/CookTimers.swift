//
//  CookTimers.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/03.
//

import SwiftUI

struct CookTimers: View {
    @EnvironmentObject var store: AppStore
    let geometry: GeometryProxy
    
    var body: some View {
        HStack {
            ForEach(0 ..< 3, id: \.self) { idx in
                Spacer()
                VStack {
                    Text(store.state.timers[idx].timerTitle ?? "")
                    CookTimer(geometry: geometry, _timerIndex: idx)
                }
                Spacer()
            }
        }
    }
}

struct CookTimer: View {
    @EnvironmentObject var store: AppStore
    
    let geometry: GeometryProxy
    var _timerIndex: Int
    var timerIndex: Int {
        get { if _timerIndex >= 0 && _timerIndex < store.state.timers.count
            { return _timerIndex }
            return 0 }
        set { _timerIndex = newValue }
    }
    let lineWidth: CGFloat = 10
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(store.state.timers[timerIndex].timerProgressValue) / Float(100), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: store.state.timers[timerIndex].timerProgressValue)
        }
        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
        .padding()
        
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
