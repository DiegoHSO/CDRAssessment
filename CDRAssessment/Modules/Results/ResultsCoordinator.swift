//
//  ResultsCoordinator.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

class ResultsCoordinator: Coordinator {
    
    // MARK: - Properties
    var viewModel: ResultsViewModel
    let rootNavigationController: UINavigationController
    
    // MARK: - Coordinator
    init(rootNavigationController: UINavigationController, answers: [String: Int]) {
        self.rootNavigationController = rootNavigationController
        self.viewModel = ResultsViewModel(answers: answers)
    }
    
    override func start() {
        let viewController = ResultsViewController(coordinator: self, viewModel: viewModel)
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    override func finish() {
        rootNavigationController.popToRootViewController(animated: true)
    }
    
    func goToMainMenu() {
        finish()
    }
    
}
