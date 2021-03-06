//
//  AppActions.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import Foundation

enum AppAction {
    // MARK: - PastaLibrary View
    case initConfigAndTimer
    case goToDetailStage
    case goToConfigStage
    
    // MARK: - preconfiguration view
    case amountButtonPressed(Int)
    case cookLevelButtonPressed(Int)
    case goToCookingStage
    case setNumberOfPeople(Int)
    case setConfigs(Int, Int, Int)
    
    // MARK: - CookingGuide View
    case updateScreenDrag(Float)
    case turnPageForward
    case turnPageBackward
    
    // MARK: - About Timer
    case setTimer(Int, String, TimeInterval)
    case countTime(Int)
    case resetTimer(Int)
    case toggleTimer(Int)
}

enum TimerAction {
    case setTimer(Int, String, TimeInterval)
    case countTime(Int)
}
