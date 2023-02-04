//
//  CategoriesMemStore.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 03/02/23.
//

import Foundation

class CategoriesMemStore: CategoriesStoreProtocol, CategoriesStoreUtilityProtocol {
    func fetchCategories(completionHandler: @escaping ([Category], CategoriesStoreError?) -> Void) {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            completionHandler([], CategoriesStoreError.CannotFetch("There was an error creating JSON URL."))
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            do {
                if let categories = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] {
                    let mappedCategories: [Category] = categories.compactMap {
                        guard let name = $0["name"] as? String,
                              let numberOfQuestions = $0["numberOfQuestions"] as? Int,
                              let questions = $0["questions"] as? [String] else {
                            return nil
                        }
                        return Category(name: name, numberOfQuestions: numberOfQuestions, questions: questions)
                    }
                    completionHandler(mappedCategories, nil)
                }
                
            } catch {
                completionHandler([], CategoriesStoreError.CannotFetch("There was an error serializing JSON file."))
            }
        } catch {
            completionHandler([], CategoriesStoreError.CannotFetch("There was an error reading JSON file."))
        }
    }
    
    func fetchCategory(id: String, completionHandler: @escaping (Category?, CategoriesStoreError?) -> Void) {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            completionHandler(nil, CategoriesStoreError.CannotFetch("There was an error creating JSON URL."))
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            do {
                if let categories = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                    guard let category = categories[id] as? [String: Any],
                          let name = category["name"] as? String,
                          let numberOfQuestions = category["numberOfQuestions"] as? Int,
                          let questions = category["questions"] as? [String] else {
                        completionHandler(nil, CategoriesStoreError.CannotFetch("There was an error creating Category object."))
                        return
                    }
                    let finalCategory = Category(name: name, numberOfQuestions: numberOfQuestions, questions: questions)
                    completionHandler(finalCategory, nil)
                }
            } catch {
                completionHandler(nil, CategoriesStoreError.CannotFetch("There was an error serializing JSON file."))
            }
        } catch {
            completionHandler(nil, CategoriesStoreError.CannotFetch("There was an error reading JSON file."))
        }
    }
    
    
}
