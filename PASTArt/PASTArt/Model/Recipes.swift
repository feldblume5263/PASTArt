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
    case spaghetti
    case spaghettini
    
    var cookDuration: [CookLevel: CookTimeInterval] {
        switch self {
        case .spaghetti:
            return [.acerbo: 360.0, .aldente: 420.0, .bencotto: 480.0]
        case .spaghettini:
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
