//
//  ResultsViewModel.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

public final class ResultsViewModel {
    
    var selectedAnswers: [String: Int]
    var score: Int = 0
    var scoreCategory: String = ""
    
    init(answers: [String: Int]) {
        selectedAnswers = answers
    }
    
    func getScoreValue() -> String {
        return ""
    }
    
    func getScoreCategory() -> String {
        return ""
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
        
        var newResults = Dictionary(uniqueKeysWithValues: tupleArray)
        
        // MARK: Memory score
        let memoryScore: Float = newResults["memory"] ?? 0
        
        // MARK: Secondary categories score
        var secondaryCategoriesScore = newResults
        secondaryCategoriesScore.removeValue(forKey: "memory")
        
        // MARK: Secondary categories with score equal to Memory
        let secondaryEqualToMemory = secondaryCategoriesScore.mapValues { value in
            return value == memoryScore ? value : nil
        }
        
        let secondaryEqualToMemorySum: Float = secondaryEqualToMemory.compactMap { $0.value! }.reduce(0, +)
        
        // MARK: Secondary categories with score bigger than Memory
        let secondaryBiggerThanMemory = secondaryCategoriesScore.mapValues { value in
            return value > memoryScore ? value : nil
        }
        
        let secondaryBiggerThanMemorySum: Float = secondaryBiggerThanMemory.compactMap { $0.value! }.reduce(0, +)
        
        // MARK: Secondary categories with score lesser than Memory
        let secondaryLesserThanMemory = secondaryCategoriesScore.mapValues { value in
            return value < memoryScore ? value : nil
        }
        
        let secondaryLesserThanMemorySum: Float = secondaryLesserThanMemory.compactMap { $0.value! }.reduce(0, +)
        
        // MARK: Total sum from secondary categories with value different than Memory
        let totalSumSecondaryCategories: Float = secondaryBiggerThanMemorySum + secondaryLesserThanMemorySum
        
        // MARK: Which side of Memory is the largest
        let side: Direction = secondaryBiggerThanMemorySum > secondaryLesserThanMemorySum ? .right : secondaryLesserThanMemorySum > secondaryBiggerThanMemorySum ? .left : .tie
        
        // MARK: Two secondary categories one side, three on the other
        let twoCategoriesOneSideThreeOnAnother: Bool = totalSumSecondaryCategories != 5 ? false :
        (secondaryBiggerThanMemorySum.isEqual(to: 2) || secondaryBiggerThanMemorySum.isEqual(to: 3)) &&
        (secondaryLesserThanMemorySum.isEqual(to: 2) || secondaryLesserThanMemorySum.isEqual(to: 3)) ? true : false
        
        // MARK: Take out left and right vectors
        let leftVector = secondaryLesserThanMemory
        let rightVector = secondaryBiggerThanMemory
        
        // MARK: Sum secondary categories with value >= 1
        let secondaryBiggerThanOne = secondaryCategoriesScore.mapValues { value in
            return value >= 1 ? value : nil
        }
        
        let secondaryBiggerThanOneSum: Float = secondaryBiggerThanOne.compactMap { $0.value! }.reduce(0, +)
        
        // MARK: Sum secondary categories with value >= 0.5
        let secondaryBiggerThanPointFive = secondaryCategoriesScore.mapValues { value in
            return value >= 0.5 ? value : nil
        }
        
        let secondaryBiggerThanPointFiveSum: Float = secondaryBiggerThanPointFive.compactMap { $0.value! }.reduce(0, +)
        
        // MARK: - Assign a diagnosis
        
        // Standard value given to each person in order to track diagnosis through rules
        var cdr: Float = 100
        
        // MARK: MAIN RULES
        
        // MARK: Three or more secondary categories with the same value as Memory
        let secondaryEqualToMemoryValues = secondaryEqualToMemory.compactMap { $0.value }
        if secondaryEqualToMemoryValues.count >= 3 {
            cdr = memoryScore
        }
        
        
        
    }
}

enum Direction {
    case right
    case left
    case tie
}
