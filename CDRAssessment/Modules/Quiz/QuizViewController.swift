//
//  QuizViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class QuizViewController: BaseViewController {
    
    weak var coordinator: QuizCoordinator?
    var viewModel: QuizViewModel
    var selectedRow: Int?
    private let quizCategories: [QuizCategories] = QuizCategories.allCases
    
    @IBOutlet weak var tableView: UITableView!
    
    init(coordinator: QuizCoordinator, viewModel: QuizViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //        titleLabel.text = NSLocalizedString("title", comment: "")
        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        observe(viewModel.$currentState) { [weak self] state in
            guard let self = self else { return }
            self.changed(state: state)
        }
    }
    
    func changed(state: State) {
        if viewModel.shouldGoToResults() {
            coordinator?.goToResults(answers: viewModel.getAnswers())
            viewModel.resetData()
            return
        }
        
        selectedRow = viewModel.getCurrentSelectedAnswer()
        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        tableView.reloadData()
        
        if viewModel.shouldInsertBackButton() {
            reconfigureButtons()
        } else {
            backButton.removeFromSuperview()
        }
        
    }
    
    func reconfigureButtons() {
        nextButton.removeFromSuperview()
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(nextButton)
        backButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        stackView.layoutIfNeeded()
    }
    
}

extension QuizViewController: ButtonsDelegate {
    func didPressBackButton() {
        viewModel.previousCategory()
        selectedRow = viewModel.getCurrentSelectedAnswer()
    }
    
    func didPressNextButton() {
        guard let selectedRow else { return }
        viewModel.nextCategory(selectedAnswer: selectedRow)
    }
}

extension QuizViewController: UITableViewDelegate {
    
}

extension QuizViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch quizCategories[indexPath.row] {
        case .question:
            if let selectedRow {
                if selectedRow == indexPath.row {
                    return
                }
                
                if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: indexPath.section)) {
                    previousCell.textLabel!.font = UIFont.systemFont(ofSize: 15)
                    previousCell.backgroundColor = UIColor.clear
                }
            }
            
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            UIView.animate(withDuration: 0.5) {
                cell.backgroundColor = UIColor.systemYellow
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            }
            selectedRow = indexPath.row
        default:
            return
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberofQuestions() + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch quizCategories[indexPath.row] {
        case .progressBar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgressBarTableViewCell.identifier, for: indexPath) as? ProgressBarTableViewCell else {
                return UITableViewCell()
            }
            
            let value = CGFloat(viewModel.currentState.rawValue) / CGFloat(State.allCases.endIndex + 1)
            cell.progressBar.configProgressValue(value: value)
            return cell
            
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            
            cell.categoryLabel.text = viewModel.getCurrentCategoryTitle()
            return cell
            
        case .question:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else {
                return UITableViewCell()
            }
            
            if let selectedRow, selectedRow == indexPath.row {
                cell.questionView.backgroundColor = UIColor(named: "selectedColor")
                //                cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            }
            
            cell.questionLabel.text = viewModel.getQuestion(for: indexPath.row)
            cell.questionLabel.numberOfLines = 4
            return cell
            
        case .buttons:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableViewCell.identifier, for: indexPath) as? ButtonsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    
}
