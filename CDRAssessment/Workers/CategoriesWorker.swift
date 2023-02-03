//
//  CategoriesWorker.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 03/02/23.
//

import Foundation

class CategoriesWorker
{
    var categoriesStore: CategoriesStoreProtocol
    
    init(categoriesStore: CategoriesStoreProtocol)
    {
        self.categoriesStore = categoriesStore
    }
    
    func fetchCategories(completionHandler: @escaping ([Category], CategoriesStoreError?) -> Void)
    {
        categoriesStore.fetchCategories { categories, error in
            if let error {
                completionHandler([], error)
            } else {
                completionHandler(categories, nil)
            }
        }
    }
    
    func fetchCategory(id: String, completionHandler: @escaping (Category?, CategoriesStoreError?) -> Void)
    {
        categoriesStore.fetchCategory(id: id) { category, error in
            if let error {
                completionHandler(nil, error)
            } else {
                completionHandler(category, nil)
            }
        }
    }
}

// MARK: - Categories store API

protocol CategoriesStoreProtocol
{
  // MARK: CRUD operations - Optional error
  
  func fetchCategories(completionHandler: @escaping ([Category], CategoriesStoreError?) -> Void)
  func fetchCategory(id: String, completionHandler: @escaping (Category?, CategoriesStoreError?) -> Void)
}

protocol CategoriesStoreUtilityProtocol {}

enum CategoriesStoreError: Equatable, Error
{
  case CannotFetch(String)
}

func ==(lhs: CategoriesStoreError, rhs: CategoriesStoreError) -> Bool
{
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
  default: return false
  }
}
