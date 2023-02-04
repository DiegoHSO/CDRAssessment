//
//  ResultsViewModel.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

public final class ResultsViewModel {
    
    var selectedAnswers: [String: Int]
    var score: CDR?
    
    init(answers: [String: Int]) {
        selectedAnswers = answers
    }
    
    func resetData() {
        selectedAnswers = [:]
        score = nil
    }
    
    func getScoreValue() -> String {
        guard let value = score?.rawValue else {
            return ""
        }
        return String(value)
    }
    
    func getScoreCategory() -> String {
        guard let value = score?.description else {
            return ""
        }
        return value
    }
    
    func calculateCDRScale() {
        let tupleArray: [(String, Float)] = selectedAnswers.map { (key: String, value: Int) in
            let floatValue: Float = Float(value)
            
            if key == "personalCare" {
                return (key, floatValue)
            } else {
                return (key, floatValue == 1 ? 0.5 : floatValue == 0 ? floatValue : floatValue - 1)
            }
        }
        
        let newResults = Dictionary(uniqueKeysWithValues: tupleArray)
        
        // MARK: Memory score
        let memoryScore: Float = newResults["memory"] ?? 0
        
        // MARK: Secondary categories score
        var secondaryCategoriesScore = newResults
        secondaryCategoriesScore.removeValue(forKey: "memory")
        
        // MARK: Secondary categories with score equal to Memory
        let secondaryEqualToMemory = secondaryCategoriesScore.mapValues { value in
            return value == memoryScore ? value : nil
        }
        
        let secondaryEqualToMemorySum = secondaryEqualToMemory.compactMap { $0.value }.count
        
        // MARK: Secondary categories with score bigger than Memory
        let secondaryBiggerThanMemory = secondaryCategoriesScore.mapValues { value in
            return value > memoryScore ? value : nil
        }
        
        let secondaryBiggerThanMemorySum = secondaryBiggerThanMemory.compactMap { $0.value }.count
        
        // MARK: Secondary categories with score lesser than Memory
        let secondaryLesserThanMemory = secondaryCategoriesScore.mapValues { value in
            return value < memoryScore ? value : nil
        }
        
        let secondaryLesserThanMemorySum = secondaryLesserThanMemory.compactMap { $0.value }.count
        
        // MARK: Total sum from secondary categories with value different than Memory
        let totalSumSecondaryCategories = secondaryBiggerThanMemorySum + secondaryLesserThanMemorySum
        
        // MARK: Which side of Memory is the largest
        let side: Direction = secondaryBiggerThanMemorySum > secondaryLesserThanMemorySum ? .right : secondaryLesserThanMemorySum > secondaryBiggerThanMemorySum ? .left : .tie
        
        // MARK: Two secondary categories one side, three on the other
        let twoCategoriesOneSideThreeOnAnother: Bool = totalSumSecondaryCategories != 5 ? false :
        (secondaryBiggerThanMemorySum == 2 || secondaryBiggerThanMemorySum == 3) &&
        (secondaryLesserThanMemorySum == 2 || secondaryLesserThanMemorySum == 3) ? true : false
        
        // MARK: Take out left and right vectors
        let leftVector = secondaryLesserThanMemory.compactMap { $0.value }
        let rightVector = secondaryBiggerThanMemory.compactMap { $0.value }
        
        // MARK: Sum secondary categories with value >= 1
        let secondaryBiggerThanOne = secondaryCategoriesScore.mapValues { value in
            return value >= 1 ? value : nil
        }
        
        let secondaryBiggerThanOneSum: Int = secondaryBiggerThanOne.compactMap { $0.value }.count
        
        // MARK: Sum secondary categories with value >= 0.5
        let secondaryBiggerThanPointFive = secondaryCategoriesScore.mapValues { value in
            return value >= 0.5 ? value : nil
        }
        
        let secondaryBiggerThanPointFiveSum: Int = secondaryBiggerThanPointFive.compactMap { $0.value }.count
        
        // MARK: - Assign a diagnosis
        
        // Standard value given to each person in order to track diagnosis through rules
        var cdr: Float = 100
        
        // MARK: MAIN RULES
        
        // MARK: Three or more secondary categories with the same value as Memory
        let secondaryEqualToMemoryValues = secondaryEqualToMemory.compactMap { $0.value }
        if secondaryEqualToMemoryValues.count >= 3 {
            cdr = memoryScore
        }
        
        // MARK: Three or more secondary categories with value != Memory
        if totalSumSecondaryCategories >= 3 {
            // if right
            if side == .right {
                let mostFrequent = rightVector.mostFrequent?.mostFrequent
                if let mostFrequent = mostFrequent?.max() {
                    cdr = mostFrequent
                }
            } else if side == .left {
                // if left
                let mostFrequent = leftVector.mostFrequent?.mostFrequent
                if let mostFrequent = mostFrequent?.max() {
                    cdr = mostFrequent
                }
            } else {
                // if tie
                cdr = 200
            }
        }
        
        // MARK: Three secondary categories on one side of Memory, two on the other
        if twoCategoriesOneSideThreeOnAnother {
            cdr = memoryScore
        }
        
        // MARK: SECONDARY RULES
        
        // if Memory = 0.5 then CDR = 1 if there are at least three secondary categories >= 1
        if (memoryScore == 0.5 && secondaryBiggerThanOneSum >= 3) {
            cdr = 1
        }
        
        // if Memory = 0.5 then CDR cannot be 0, only 0.5 or 1
        if (memoryScore == 0.5 && cdr == 0) {
            cdr = 0.5
        }
        
        // if Memory = 0 CDR -> 0 unless there is impairment in at least two secondary categories
        if (memoryScore == 0) {
            cdr = 0
        }
        
        if (memoryScore == 0 && secondaryBiggerThanPointFiveSum >= 2) {
            cdr = 0.5
        }
        
        // MARK: SPECIAL RULES
        
        // (1) Ties one side of Memory, that is M + 1 = 3, the others 2 2 1 1 etc.
        if (secondaryLesserThanMemorySum == 4 && leftVector.uniqued().count == 2) {
            if let firstElement = leftVector.uniqued().first {
                let arrayOfFirstElementValues = leftVector.filter { $0 == firstElement }
                if arrayOfFirstElementValues.count == 2 {
                    if let maxValue = leftVector.uniqued().max() {
                        cdr = maxValue
                    }
                }
            }
        }
        
        if (secondaryBiggerThanMemorySum == 4 && rightVector.uniqued().count == 2) {
            if let firstElement = rightVector.uniqued().first {
                let arrayOfFirstElementValues = rightVector.filter { $0 == firstElement }
                if arrayOfFirstElementValues.count == 2 {
                    if let maxValue = rightVector.uniqued().max() {
                        cdr = maxValue
                    }
                }
            }
        }
        
        // (2) Only 1 or 2 secondary categories equal Memory
        if secondaryEqualToMemorySum == 1 || secondaryEqualToMemorySum == 2 {
            if secondaryLesserThanMemorySum <= 2 && secondaryBiggerThanMemorySum <= 2 {
                cdr = memoryScore
            }
        }
        
        // # (3) If memory >= 1 CDR cannot be 0
        let secondaryCategoriesScoreValues = secondaryCategoriesScore.compactMap { $0.value }
        if let mostFrequentValues = secondaryCategoriesScoreValues.mostFrequent?.mostFrequent {
            if (memoryScore >= 1) && (cdr == 0) && (mostFrequentValues.contains(0)) {
                cdr = 0.5
            }
        }
        
        score = CDR(rawValue: cdr)
    }
}
