//
//  ResultsViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

class ResultsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var scoreCategoryLabel: UILabel!
    @IBOutlet weak var scoreDescriptionView: UIView!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBAction func homeAction(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.resetData()
        coordinator?.finish()
    }
    
    weak var coordinator: ResultsCoordinator?
    var viewModel: ResultsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        viewModel.calculateCDRScale()
        
        scoreTextLabel.text = NSLocalizedString("score", comment: "")
        scoreValueLabel.text = viewModel.getScoreValue()
        scoreCategoryLabel.text = NSLocalizedString(viewModel.getScoreCategory(), comment: "").uppercased()
        scoreDescriptionLabel.text = NSLocalizedString("resultDescription", comment: "")
        scoreDescriptionLabel.text = scoreDescriptionLabel.text?.replacingOccurrences(of: "CATEGORY", with: scoreCategoryLabel.text?.lowercased() ?? "")
        homeLabel.text = NSLocalizedString("home", comment: "")
        // Do any additional setup after loading the view.
    }

}
