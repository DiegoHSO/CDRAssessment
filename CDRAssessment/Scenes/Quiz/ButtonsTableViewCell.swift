//
//  ButtonsTableViewCell.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 11/01/23.
//

import UIKit

protocol ButtonsDelegate: AnyObject {
    func didPressBackButton()
    func didPressNextButton()
}

class ButtonsTableViewCell: UITableViewCell {

    static let identifier = "buttonsCell"
    weak var delegate: ButtonsDelegate?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    @IBAction func nextAction(_ sender: UIButton) {
        delegate?.didPressNextButton()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        delegate?.didPressBackButton()
    }
    
    func reconfigureButtons() {
        nextButton.removeFromSuperview()
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(nextButton)
        backButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        stackView.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        nextButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        nextButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
        
        nextButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        nextButton.titleLabel?.layer.shadowOpacity = 0.7
        nextButton.titleLabel?.layer.shadowRadius = 0
        
        backButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        backButton.titleLabel?.layer.shadowOpacity = 0.7
        backButton.titleLabel?.layer.shadowRadius = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
