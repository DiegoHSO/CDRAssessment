//
//  MainMenuCoordinator.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class MainMenuCoordinator: Coordinator {
    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        let viewController = MainMenuViewController.instantiate("MainMenu")
        viewController.coordinator = self
        return UINavigationController(rootViewController: viewController)
    }()
    
    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        rootViewController.navigationBar.isHidden = true
    }
    
    override func finish() {}
    
    func goToQuiz() {
        let quizCoordinator = QuizCoordinator(rootNavigationController: rootViewController)
        addChildCoordinator(quizCoordinator)
        quizCoordinator.start()
    }
    
    func goToReferencePage() {
        if let url = URL(string: "https://knightadrc.wustl.edu/wp-content/uploads/2021/06/CDR-Scoring-Rules.pdf") {
            UIApplication.shared.open(url)
        }
    }
}


