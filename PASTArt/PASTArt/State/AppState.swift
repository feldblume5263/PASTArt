//
//  AppState.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import Foundation

struct AppState {
    // MARK: - App Stage
    var currentStage: AppStage = .settingConfig
    
    // MARK: - PastaLibrary View
    
    // MARK: - preconfiguration View
    var config = PastaCookingConfig()
    var amountButtonState: [Bool] = [true, false, false, false]
    var cookLevelButtonState: [Bool] = [false, true, false]
    
    // MARK: - CookingGuide View
    var timers = [TimerConfig(id: 0), TimerConfig(id: 1), TimerConfig(id: 2)]
    var activeCard: Int = 0
    var screenDrag: Float = 0.0
}

enum AppStage {
    case showingDetail
    case settingConfig
    case cookingPasta
}

struct PastaCookingConfig {
    var numberOfPeople: Int?
    var typeOfNoodle: Noodle?
    var cookingLevel: CookLevel?
}
