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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextAction(_ sender: UIButton) {
        guard let selectedRow else { return }
        viewModel.nextCategory(selectedAnswer: selectedRow)
    }
    
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
        titleLabel.text = NSLocalizedString("title", comment: "")
        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
        observe(viewModel.$currentState) { [weak self] state in
            guard let self = self else { return }
            self.changed(state: state)
        }
    }
    
    func changed(state: State) {
        selectedRow = nil
        categoryLabel.text = viewModel.getCurrentCategoryTitle()
        tableView.reloadData()
    }
    
}

extension QuizViewController: UITableViewDelegate {
    
}

extension QuizViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
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
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        selectedRow = indexPath.row
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberofQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel!.text = viewModel.getQuestion(for: indexPath.row)
        cell.textLabel!.numberOfLines = 4
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    
}
