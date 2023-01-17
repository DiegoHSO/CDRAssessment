//
//  ViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class MainMenuViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var leftUpperBubbleView: UIView!
    @IBOutlet weak var rightUpperBubbleView: UIView!
    @IBOutlet weak var leftLowerBubbleView: UIView!
    @IBOutlet weak var rightLowerBubbleView: UIView!
    @IBOutlet weak var rightCenterBubbleView: UIView!
    @IBOutlet weak var leftCenterBubbleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var coordinator: MainMenuCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupBubbleViews()
    }
    
    private func setupBubbleViews() {
        leftUpperBubbleView.layer.cornerRadius = leftUpperBubbleView.frame.height / 2
        rightUpperBubbleView.layer.cornerRadius = rightUpperBubbleView.frame.height / 2
        leftLowerBubbleView.layer.cornerRadius = leftLowerBubbleView.frame.height / 2
        rightLowerBubbleView.layer.cornerRadius = rightLowerBubbleView.frame.height / 2
        leftCenterBubbleView.layer.cornerRadius = leftCenterBubbleView.frame.height / 2
        rightCenterBubbleView.layer.cornerRadius = rightCenterBubbleView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.removeAllChildCoordinators()
    }
    
}

extension MainMenuViewController: MainMenuDelegate {
    func didTapReferenceButton() {
        coordinator?.goToReferencePage()
    }
    
    func didTapStartButton() {
        coordinator?.goToQuiz()
    }
    
    func didTapRemoveAdsButton() {
        
    }
}

extension MainMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as? MainMenuTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        return cell
    }
}

extension MainMenuViewController: UITableViewDelegate {
    
}
