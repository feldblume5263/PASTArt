//
//  PastaInfos.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/06.
//

import Foundation

struct PastaInfo: Identifiable {
    let id = UUID()
    let pasta: Pasta
    let name: String
    let time: String
    let picture: String
    let ingredient: [Ingredient]
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let scale: String
}


let pastaInfos: [PastaInfo] = [
    PastaInfo(pasta: .pomodoro, name: "Pomodoro", time: "20min", picture: "pomodoro",
              ingredient: [
                Ingredient(name: "토마토 퓨레", amount: 1, scale: "캔"),
                Ingredient(name: "양파", amount: 1, scale: "개"),
                Ingredient(name: "마늘", amount: 2, scale: "개"),
                Ingredient(name: "파스타면", amount: 300, scale: "g"),
                Ingredient(name: "파슬리", amount: 1, scale: "줄기")
              ]),
    PastaInfo(pasta: .alfredo, name: "Alfredo", time: "23min", picture: "alfredo",
              ingredient: [
                Ingredient(name: "생크림", amount: 200, scale: "ml"),
                Ingredient(name: "우유", amount: 200, scale: "ml"),
                Ingredient(name: "양파", amount: 1, scale: "개"),
                Ingredient(name: "마늘", amount: 2, scale: "개"),
                Ingredient(name: "파스타면", amount: 300, scale: "g"),
                Ingredient(name: "파슬리", amount: 1, scale: "줄기")
              ]),
    PastaInfo(pasta: .alioOilo, name: "Alio e Olio", time: "20min", picture: "alioeolio",
              ingredient: [
                Ingredient(name: "올리브유", amount: 100, scale: "ml"),
                Ingredient(name: "마늘", amount: 5, scale: "개"),
                Ingredient(name: "파스타면", amount: 300, scale: "g"),
                Ingredient(name: "파슬리", amount: 1, scale: "줄기"),
                Ingredient(name: "페퍼론치노", amount: 30, scale: "g")
              ])
]
