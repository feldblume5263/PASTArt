//
//  Reducers.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    
    // MARK: - preconfiguration view
    case .amountButtonPressed(let buttonIdx):
        state.amountButtonState = [Bool](repeating: false, count: state.amountButtonState.count)
        state.amountButtonState[buttonIdx] = true
    
    case .cookLevelButtonPressed(let buttonIdx):
        state.cookLevelButtonState = [Bool](repeating: false, count: state.cookLevelButtonState.count)
        state.cookLevelButtonState[buttonIdx] = true
        
    case .goToCookingStage:
        state.currentStage = .cookingPasta
    }
}
