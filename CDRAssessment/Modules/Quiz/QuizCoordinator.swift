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
        let viewController = QuizViewController.instantiate("Quiz")
        viewController.coordinator = self
        viewController.viewModel = viewModel
        rootNavigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        rootNavigationController.popViewController(animated: true)
    }
    
    func goToResults(answers: [String: Int]) {
        let resultsCoordinator = ResultsCoordinator(rootNavigationController: rootNavigationController, answers: answers)
        addChildCoordinator(resultsCoordinator)
        resultsCoordinator.start()
    }
    
    func showHomeAlert() {
        let alert = UIAlertController(title: NSLocalizedString("backAlertTitle", comment: ""),
                                      message: NSLocalizedString("backAlertText", comment: ""),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("backAlertYes", comment: ""), style: .destructive, handler: { _ in
            self.finish()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("backAlertNo", comment: ""), style: .cancel, handler: { _ in
        }))
        
        rootNavigationController.present(alert, animated: true)
    }
}
