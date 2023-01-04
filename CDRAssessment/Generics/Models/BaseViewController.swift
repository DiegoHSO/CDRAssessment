//
//  BaseViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import Combine
import UIKit

open class BaseViewController: UIViewController {
    
    // MARK: - Stored Properties
    private var cancellables: [Cancellable] = []
    
    // MARK: - Initializers
    deinit {
        removeObservers()
    }
}

// MARK: - Public Methods
extension BaseViewController {
    
    public func observe<Type>(_ publisher: Published<Type>.Publisher, action: @escaping (Type) -> Void) {
        cancellables.append(publisher.receive(on: DispatchQueue.main).sink { value in
            action(value)
        })
    }
    
    public func removeObservers() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
}

