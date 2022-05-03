//
//  Enum.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/02.
//

import Foundation

extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
