//
//  AppState.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/30.
//

import Foundation

enum AppStage {
    case showingMenus
    case showingDetail
    case settingConfig
    case cookingPasta
}


struct AppState {
    // MARK: - App Stage
    var currentStage: AppStage = .settingConfig
    
    
    // MARK: - preconfiguration view
    var amountButtonState: [Bool] = [true, false, false, false]
    var cookLevelButtonState: [Bool] = [false, true, false]
}
