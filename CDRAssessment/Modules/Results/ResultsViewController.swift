//
//  ResultsViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 05/01/23.
//

import UIKit

class ResultsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var leftUpperBubbleView: UIView!
    @IBOutlet weak var rightUpperBubbleView: UIView!
    @IBOutlet weak var leftLowerBubbleView: UIView!
    @IBOutlet weak var rightLowerBubbleView: UIView!
    @IBOutlet weak var rightCenterBubbleView: UIView!
    @IBOutlet weak var leftCenterBubbleView: UIView!
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
        
        setupViews()
        setupBubbleViews()
    }
    
    private func setupViews() {
        guard let viewModel = viewModel else { return }
        
        scoreTextLabel.text = NSLocalizedString("score", comment: "")
        scoreValueLabel.text = viewModel.getScoreValue()
        scoreCategoryLabel.text = NSLocalizedString(viewModel.getScoreCategory(), comment: "").uppercased()
        scoreDescriptionLabel.text = NSLocalizedString("resultDescription", comment: "")
        scoreDescriptionLabel.text = scoreDescriptionLabel.text?.replacingOccurrences(of: "CATEGORY", with: scoreCategoryLabel.text?.lowercased() ?? "")
        
        scoreView.layer.shadowColor = UIColor.black.cgColor
        scoreView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        scoreView.layer.shadowOpacity = 0.5
        scoreView.layer.shadowRadius = 5.0
        
        scoreDescriptionView.layer.shadowColor = UIColor.black.cgColor
        scoreDescriptionView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        scoreDescriptionView.layer.shadowOpacity = 0.1
        scoreDescriptionView.layer.shadowRadius = 5.0
        
        homeLabel.text = NSLocalizedString("home", comment: "")
        homeLabel.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
        homeLabel.layer.shadowOpacity = 0.7
        homeLabel.layer.shadowRadius = 0
    }
    
    private func setupBubbleViews() {
        leftUpperBubbleView.layer.cornerRadius = leftUpperBubbleView.frame.height / 2
        rightUpperBubbleView.layer.cornerRadius = rightUpperBubbleView.frame.height / 2
        leftLowerBubbleView.layer.cornerRadius = leftLowerBubbleView.frame.height / 2
        rightLowerBubbleView.layer.cornerRadius = rightLowerBubbleView.frame.height / 2
        leftCenterBubbleView.layer.cornerRadius = leftCenterBubbleView.frame.height / 2
        rightCenterBubbleView.layer.cornerRadius = rightCenterBubbleView.frame.height / 2
    }

}
