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
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var referenceButton: UIButton!
    
    @IBAction func startAction(_ sender: UIButton) {
        coordinator?.goToQuiz()
    }
    
    @IBAction func referenceAction(_ sender: UIButton) {
        coordinator?.goToReferencePage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = NSLocalizedString("title", comment: "")
        subtitleLabel.text = NSLocalizedString("subtitle", comment: "")
        developerLabel.text = NSLocalizedString("developer", comment: "")
        startButton.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        referenceButton.setTitle(NSLocalizedString("reference", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.removeAllChildCoordinators()
    }
    
}

