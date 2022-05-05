//
//  TimerConfig.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/04.
//

import Foundation

struct TimerConfig: Identifiable {
    var id: Int
    var isOccupied: Bool = false
    var title: String?
    var currentCount: TimeInterval = 0
    var duration: TimeInterval = 0
}
