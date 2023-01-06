//
//  ResultsViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var scoreCategoryLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBAction func homeAction(_ sender: UIButton) {
        coordinator?.finish()
    }
    
    weak var coordinator: ResultsCoordinator?
    var viewModel: ResultsViewModel
    
    init(coordinator: ResultsCoordinator, viewModel: ResultsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = NSLocalizedString("title", comment: "")
        subtitleLabel.text = NSLocalizedString("result", comment: "")
        scoreTextLabel.text = NSLocalizedString("score", comment: "")
//        scoreValueLabel.text = viewModel.getScoreValue()
//        scoreCategoryLabel.text = viewModel.getScoreCategory()
        homeButton.setTitle(NSLocalizedString("home", comment: ""), for: .normal)
        viewModel.calculateCDRScale()
        // Do any additional setup after loading the view.
    }

}
