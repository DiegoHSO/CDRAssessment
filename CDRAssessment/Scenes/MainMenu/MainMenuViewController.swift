//
//  ViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

protocol MainMenuDisplayLogic: AnyObject
{
    func displayFetchedTexts(viewModel: MainMenu.FetchTexts.ViewModel)
}

class MainMenuViewController: UIViewController, Storyboarded, MainMenuDisplayLogic {
    
    var interactor: MainMenuBusinessLogic?
    var router: (NSObjectProtocol & MainMenuRoutingLogic & MainMenuDataPassing)?
    
    @IBOutlet private weak var leftUpperBubbleView: UIView!
    @IBOutlet private weak var rightUpperBubbleView: UIView!
    @IBOutlet private weak var leftLowerBubbleView: UIView!
    @IBOutlet private weak var rightLowerBubbleView: UIView!
    @IBOutlet private weak var rightCenterBubbleView: UIView!
    @IBOutlet private weak var leftCenterBubbleView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    weak var coordinator: MainMenuCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setup()
        setupBubbleViews()
    }
    
    private func setup() {
        let viewController = self
        let interactor = MainMenuInteractor()
        let presenter = MainMenuPresenter()
        let router = MainMenuRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
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
        super.viewWillAppear(animated)
        fetchTexts()
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
        guard let url = displayedTexts?.referenceStudyURL else { return }
        router?.routeToReferencePage(url: url)
    }
    
    func didTapStartButton() {
        router?.routeToQuiz()
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
        cell.referenceButton.setTitle(displayedTexts?.referenceButtonTitle, for: .normal)
        cell.startButton.setTitle(displayedTexts?.startButtonTitle, for: .normal)
        return cell
    }
}

extension MainMenuViewController: UITableViewDelegate {
    
}
