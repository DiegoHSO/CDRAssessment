//
//  QuizViewController.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 04/01/23.
//

import UIKit

class QuizViewController: BaseViewController, Storyboarded {
    
    weak var coordinator: QuizCoordinator?
    var viewModel: QuizViewModel?
    var selectedRow: Int?
    private let quizCategories: [QuizCategories] = QuizCategories.allCases
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //        titleLabel.text = NSLocalizedString("title", comment: "")
//        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        guard let viewModel = viewModel else { return }
        observe(viewModel.$currentState) { [weak self] state in
            guard let self = self else { return }
            self.changed(state: state)
        }
    }
    
    func changed(state: State) {
        guard let viewModel = viewModel else { return }
        if viewModel.shouldGoToResults() {
            coordinator?.goToResults(answers: viewModel.getAnswers())
            viewModel.resetData()
            return
        }
        
        selectedRow = viewModel.getCurrentSelectedAnswer()
//        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        tableView.reloadData()
    }
    
}

extension QuizViewController: ButtonsDelegate {
    func didPressBackButton() {
        guard let viewModel = viewModel else { return }
        viewModel.previousCategory()
        selectedRow = viewModel.getCurrentSelectedAnswer()
    }
    
    func didPressNextButton() {
        guard let viewModel = viewModel else { return }
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
        guard let viewModel = viewModel else { return 3 }
        return viewModel.getNumberofQuestions() + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
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
            
            if viewModel.shouldInsertBackButton() {
                cell.reconfigureButtons()
            } else {
                cell.backButton.removeFromSuperview()
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    
}
