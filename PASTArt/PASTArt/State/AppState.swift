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
