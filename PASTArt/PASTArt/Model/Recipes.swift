//
//  Recipes.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import Foundation

typealias CookTimeInterval = TimeInterval

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

struct Recipes {
    let NoodleRecipe: RecipeCard
    let AfterNoodleRecipe: [RecipeCard]
}

struct RecipeCard {
    let stepName: String
    let description: String
    var duration: [TimeInterval]?
    let videoName: String?
}
