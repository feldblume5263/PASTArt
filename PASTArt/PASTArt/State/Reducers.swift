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
        state.amountButtonState.indices.forEach { state.amountButtonState[$0] = $0 == buttonIdx ? true : false }
    
    case .cookLevelButtonPressed(let buttonIdx):
        state.cookLevelButtonState.indices.forEach { state.cookLevelButtonState[$0] = $0 == buttonIdx ? true : false }
        
    case .goToCookingStage:
        state.currentStage = .cookingPasta
        
    case .setNumberOfPeople(let amount):
        state.config.numberOfPeople = amount
        
    case .setConfigs(let amount, let noodleIndex, let cookLevelIndex):
        state.config.numberOfPeople = amount
        state.config.typeOfNoodle = Noodle.allCases[noodleIndex]
        state.config.cookingLevel = CookLevel.allCases[cookLevelIndex]
    }
}
