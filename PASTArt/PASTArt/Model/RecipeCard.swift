//
//  RecipeCard.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import Foundation

typealias CookTimeInterval = TimeInterval
typealias TimerId = Int

class RecipeCard: Identifiable {
    let id: Int
    let stepName: String
    let description: String
    var duration: TimeInterval?
    let videoName: String?
    let isNoodle: Bool
    var timerOccupy: TimerId? = nil
    var isCounting: Bool = false
    
    init(id: Int, stepName: String, description: String, duration: TimeInterval?, videoName: String?, isNoodle: Bool) {
        self.id = id
        self.stepName = stepName
        self.description = description
        self.duration = duration
        self.videoName = videoName
        self.isNoodle = isNoodle
        self.timerOccupy = nil
        self.isCounting = false
    }
    
    
    static func getRecipesOfPasta(pasta: Pasta) -> [RecipeCard] {
        switch pasta {
        case .pomodoro:
            return pomodoroRecipes
        case .alfredo:
            return pomodoroRecipes
        case .alioOilo:
            return pomodoroRecipes
        }
    }
    
    func isOccupied(by timerIndex: Int) {
        timerOccupy = timerIndex
        isCounting = true
    }

    func isRemoved() {
        timerOccupy = nil
    }
}

enum CookLevel: String, CaseIterable {
    case acerbo
    case aldente
    case bencotto
}

enum Noodle: String, CaseIterable {
    case parpalais = "파르팔레"
    case linguini = "링귀네"
    case bucatini = "부카티니"
    case spaghetti = "스파게티"
    case spaghettini = "스파게티니"
    case tagliatelle = "탈리아탈레"
    case capelleti = "카펠리티"
    
    
    var cookDuration: [CookLevel: CookTimeInterval] {
        switch self {
        case .spaghetti:
            return [.acerbo: 360.0, .aldente: 420.0, .bencotto: 480.0]
        case .spaghettini:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        case .parpalais:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        case .linguini:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        case .bucatini:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        case .tagliatelle:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        case .capelleti:
            return [.acerbo: 420.0, .aldente: 480.0, .bencotto: 540.0]
        }
        
    }
}
