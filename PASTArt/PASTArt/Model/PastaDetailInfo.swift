//
//  Pasta.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import Foundation

enum Pasta: String {
    case pomodoro
    case alfredo
}

struct PastaDetailInfo {
    let name: String
    let imageName: String
    let cookMinutes: Int
    let ingredient: [String: [Any]]
    let description: String
}
