//
//  QuizCategories.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 11/01/23.
//

import Foundation

enum QuizCategories: CaseIterable {
    case progressBar, category, question, buttons
    
    static var allCases: [QuizCategories] {
        return [.progressBar, .category, .question, .buttons]
    }
}
