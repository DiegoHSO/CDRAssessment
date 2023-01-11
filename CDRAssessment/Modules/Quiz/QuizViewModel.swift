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
        category.loadCategory(for: state.description)
    }
    
    var selectedAnswers: [String: Int] = [:]
    var category: Category = Category(name: "", numberOfQuestions: 0, questions: [])
    
    func getAnswers() -> [String: Int] {
        return selectedAnswers
    }
    
    func resetData() {
        selectedAnswers = [:]
    }
    
    func nextCategory(selectedAnswer: Int) {
        selectedAnswers[currentState.description] = selectedAnswer
        currentState = currentState.next()
        category.loadCategory(for: currentState.description)
    }
    
    func shouldGoToResults() -> Bool {
        return selectedAnswers["personalCare"] != nil ? true : false
    }
    
    func shouldInsertBackButton() -> Bool {
        return currentState == .memory ? false : true
    }
    
    func previousCategory() {
        currentState = currentState.back()
        category.loadCategory(for: currentState.description)
    }
    
    func getCurrentSelectedAnswer() -> Int? {
        return selectedAnswers[currentState.description]
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
