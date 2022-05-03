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
    
    // MARK: - preconfiguration view
    var config = PastaCookingConfig()
    var amountButtonState: [Bool] = [true, false, false, false]
    var cookLevelButtonState: [Bool] = [false, true, false]
    var selectedNoodle = Int(Noodle.allCases.count / 2)
    
    // MARK: - CookingGuide View
    var timers = [TimerConfig(), TimerConfig(), TimerConfig()]
    var activeCard: Int = 0
    var screenDrag: Float = 0.0
}

enum AppStage {
    case showingMenus
    case showingDetail
    case settingConfig
    case cookingPasta
}

struct PastaCookingConfig {
    var numberOfPeople: Int?
    var typeOfNoodle: Noodle?
    var cookingLevel: CookLevel?
}

struct TimerConfig {
    var timerTitle: String? = nil
    var timersOccupancy: Bool = false
    var timerProgressValue: TimeInterval = 0.0
}
