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
    
    case memory = 1
    case orientation = 2
    case judgment = 3
    case communityAffairs = 4
    case homeAndHobbies = 5
    case personalCare = 6
}
