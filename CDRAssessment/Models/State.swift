//
//  State.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import Foundation

enum State: Int, CustomStringConvertible, CaseIterable {
    var description: String {
        switch self {
        case .memory:
            return "memory"
        case .orientation:
            return "orientation"
        case .judgment:
            return "judgment"
        case .communityAffairs:
            return "communityAffairs"
        case .homeAndHobbies:
            return "homeAndHobbies"
        case .personalCare:
            return "personalCare"
        }
    }
    
    case memory = 0
    case orientation = 1
    case judgment = 2
    case communityAffairs = 3
    case homeAndHobbies = 4
    case personalCare = 5
}
