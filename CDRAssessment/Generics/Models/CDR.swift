//
//  CDR.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 06/01/23.
//

import Foundation

enum CDR: Float, CustomStringConvertible {
    var description: String {
        switch self {
        case .none:
            return "none"
        case .questionable:
            return "questionable"
        case .mild:
            return "mild"
        case .moderate:
            return "moderate"
        case .severe:
            return "severe"
        }
    }
    
    case none = 0
    case questionable = 0.5
    case mild = 1
    case moderate = 2
    case severe = 3
}

enum Direction {
    case right
    case left
    case tie
}
