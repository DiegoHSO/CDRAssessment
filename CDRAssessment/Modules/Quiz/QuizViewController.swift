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
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func homeAction(_ sender: UIButton) {
        coordinator?.showHomeAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        configProgress()
        homeLabel.text = NSLocalizedString("home", comment: "")
        
        guard let viewModel = viewModel else { return }
        observe(viewModel.$currentState) { [weak self] state in
            guard let self = self else { return }
            self.changed(state: state)
        }
    }
    
    func changed(state: State) {
        guard let viewModel = viewModel else { return }
        if viewModel.shouldGoToResults() {
            progressBar.configProgressValue(value: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.coordinator?.goToResults(answers: viewModel.getAnswers())
                viewModel.resetData()
                return
            }
        } else {
            scrollToTop()
            configProgress()
            selectedRow = viewModel.getCurrentSelectedAnswer()
            tableView.reloadData()
        }
    }
    
    private func configProgress() {
        guard let viewModel = viewModel else { return }
        let value = CGFloat(viewModel.currentState.rawValue) / CGFloat(State.allCases.endIndex)
        progressBar.configProgressValue(value: value)
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow, at: .top, animated: true)
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
        
        switch indexPath.section {
        case 1:
            if let selectedRow {
                if selectedRow == indexPath.row {
                    return
                }
                
                if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: indexPath.section)) as? QuestionTableViewCell {
                    previousCell.questionView.backgroundColor = UIColor(named: "unselectedColor")
                    previousCell.questionLabel.font = UIFont(name: "SFCompactDisplay-Regular", size: 17)
                }
            }
            
            guard let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell else { return }
            UIView.animate(withDuration: 0.5) {
                cell.questionView.backgroundColor = UIColor(named: "selectedColor")
                cell.questionLabel.font = UIFont(name: "SFCompactDisplay-Medium", size: 16)
            }
            selectedRow = indexPath.row
        default:
            return
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 3 }
        if section == 0 {
            return 1
        } else if section == 1 {
            return viewModel.getNumberofQuestions()
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            
            cell.categoryLabel.text = viewModel.getCurrentCategoryTitle()
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else {
                return UITableViewCell()
            }
            
            if let selectedRow, selectedRow == indexPath.row {
                cell.questionView.backgroundColor = UIColor(named: "selectedColor")
                cell.questionLabel.font = UIFont(name: "SFCompactDisplay-Medium", size: 16)
            } else {
                cell.questionView.backgroundColor = UIColor(named: "unselectedColor")
                cell.questionLabel.font = UIFont(name: "SFCompactDisplay-Regular", size: 17)
            }
            
            cell.questionLabel.text = viewModel.getQuestion(for: indexPath.row)
            cell.questionLabel.numberOfLines = 7
            return cell
            
        case 2:
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
            
        default:
            return UITableViewCell()
        }
    }
    
    
}
