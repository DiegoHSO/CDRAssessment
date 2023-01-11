//
//  QuestionTableViewCell.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 11/01/23.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    static let identifier = "questionCell"
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        questionView.layer.borderWidth = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
