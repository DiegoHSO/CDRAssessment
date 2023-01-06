//
//  ViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class MainMenuViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainMenuCoordinator?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startAction(_ sender: UIButton) {
        coordinator?.goToQuiz()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = NSLocalizedString("title", comment: "")
        subtitleLabel.text = NSLocalizedString("subtitle", comment: "")
        startButton.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.removeAllChildCoordinators()
    }
    
}

