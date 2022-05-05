//
//  AppStore.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import Foundation

typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {
    
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    
    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        reducer(&state, action)
    }
    
    static func getTimeString(count: TimeInterval, duration: TimeInterval, addSymbol: Bool) -> String {
        var ret: String = ""
        if addSymbol {
            if count < duration {
                if duration - count < 1 { return " " }
                ret += "-"
            } else {
                ret += "+"
            }
        }
        let timeGap = abs(count - duration)
        let min = Int(timeGap / 60)
        let sec = Int(timeGap) % 60
        if min > 0 { ret += (String(min) + "분") }
        if sec > 0 {
            if sec < 10 { ret += "0" }
            ret += (String(sec) + "초")
        }
        return ret
    }
}
