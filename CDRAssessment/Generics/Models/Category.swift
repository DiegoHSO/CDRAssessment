//
//  Category.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import Foundation

struct Category {
    var name: String
    var numberOfQuestions: Int
    var questions: [String]
    
    mutating func loadCategory(for category: String) {
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        
        let jsonData = try! Data(contentsOf: url)
        if let categories = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
            let currentCategory = categories[category] as? [String: Any]
            name = currentCategory?["name"] as? String ?? ""
            numberOfQuestions = currentCategory?["numberOfQuestions"] as? Int ?? 0
            questions = currentCategory?["questions"] as? [String] ?? []
        }
    }
}
