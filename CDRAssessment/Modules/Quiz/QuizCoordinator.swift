//
//  QuizCoordinator.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class QuizCoordinator: Coordinator {
    
    // MARK: - Properties
    var viewModel: QuizViewModel
    let rootNavigationController: UINavigationController
    
    // MARK: - Coordinator
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        self.viewModel = QuizViewModel(state: .memory)
    }
    
    override func start() {
        let viewController = QuizViewController(coordinator: self, viewModel: viewModel)
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    override func finish() {
        rootNavigationController.popViewController(animated: true)
    }
}
