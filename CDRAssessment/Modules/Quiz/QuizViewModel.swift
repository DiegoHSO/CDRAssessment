//
//  QuizViewModel.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import Foundation

public final class QuizViewModel {
    @Published var currentState: State
    
    init(state: State) {
        currentState = state
        category.loadCategory(for: state.rawValue)
    }
    
    var selectedAnswers: [String: Int] = [:]
    var category: Category = Category(name: "", numberOfQuestions: 0, questions: [])
    
    func nextCategory(selectedAnswer: Int) {
        selectedAnswers[currentState.rawValue] = selectedAnswer
        currentState = currentState.next()
        category.loadCategory(for: currentState.rawValue)
    }
    
    func shouldInsertBackButton() -> Bool {
        return currentState == .memory ? false : true
    }
    
    func previousCategory() {
        currentState = currentState.back()
        category.loadCategory(for: currentState.rawValue)
    }
    
    func getCurrentSelectedAnswer() -> Int? {
        return selectedAnswers[currentState.rawValue]
    }
    
    func getCurrentCategoryTitle() -> String {
        return category.name
    }
    
    func getNumberofQuestions() -> Int {
        return category.numberOfQuestions
    }
    
    func getQuestion(for index: Int) -> String {
        return category.questions[index]
    }
}
