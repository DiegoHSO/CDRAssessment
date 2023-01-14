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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
