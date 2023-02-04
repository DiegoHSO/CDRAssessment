//
//  ViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

protocol MainMenuDisplayLogic: AnyObject
{
    func displayFetchedTexts(viewModel: MainMenu.FetchTexts.ViewModel.DisplayedTexts)
}

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
    
    // MARK: - Fetch orders
    
    var displayedTexts: MainMenu.FetchTexts.ViewModel.DisplayedTexts? = nil
    
    func fetchTexts()
    {
      let request = MainMenu.FetchTexts.Request()
      interactor?.fetchTexts(request: request)
    }
    
    func displayFetchedTexts(viewModel: MainMenu.FetchTexts.ViewModel)
    {
      displayedTexts = viewModel.displayedTexts
      tableView.reloadData()
    }
    
}

extension MainMenuViewController: MainMenuDelegate {
    func didTapReferenceButton() {
        router?.goToReferencePage()
    }
    
    func didTapStartButton() {
        router?.goToQuiz()
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
        cell.titleLabel.text = displayedTexts?.title
        cell.subtitleLabel.text = displayedTexts?.subtitle
        cell.referenceButton.titleLabel?.text = displayedTexts?.referenceButtonTitle
        cell.startButton.titleLabel?.text = displayedTexts?.startButtonTitle
        return cell
    }
}

extension MainMenuViewController: UITableViewDelegate {
    
}
