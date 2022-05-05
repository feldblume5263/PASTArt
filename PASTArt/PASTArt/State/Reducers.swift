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
    
    // MARK: - PastaLibrary View
    case .initConfigAndTimer:
        state.currentStage = .settingConfig
        state.config = PastaCookingConfig()
        state.amountButtonState = [true, false, false, false]
        state.cookLevelButtonState = [false, true, false]
        state.timers = [TimerConfig(id: 0), TimerConfig(id: 1), TimerConfig(id: 2)]
        state.activeCard = 0
        state.screenDrag = 0.0
    
    case .goToDetailStage:
        state.currentStage = .showingDetail
        
    case .goToConfigStage:
        state.currentStage = .settingConfig
        
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
        
        
    // MARK: - CookingGuide View
    case .updateScreenDrag(let newScreenDrag):
        state.screenDrag = newScreenDrag
        
    case .turnPageForward:
        state.activeCard += 1
        
    case .turnPageBackward:
        state.activeCard -= 1
        
    case .setTimer(let id, let title, let duration):
        state.timers[id].isOccupied = true
        state.timers[id].title = title
        state.timers[id].duration = duration
        
    case .countTime(let id):
        state.timers[id].currentCount += 0.1
        
    case .resetTimer(let id):
        state.timers[id].title = " "
        state.timers[id].isRunning = true
        state.timers[id].currentCount = 0
        state.timers[id].isOccupied = false
        state.timers[id].duration = 0.1
        
    case .toggleTimer(let id):
        state.timers[id].isRunning.toggle()
    
    }
}
