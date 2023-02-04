//
//  ProgressBarTableViewCell.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 11/01/23.
//

import UIKit

class ProgressBarTableViewCell: UITableViewCell {

    static let identifier = "progressBarCell"
    
    @IBOutlet weak var progressBar: ProgressBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBar.progressBar.progress = 1
        progressBar.configProgressValue(value: 0)
        progressBar.configProgressColors(
            progressBarColor: UIColor(named: "progressBarColor") ?? .gray,
            progressBarStatusColor: UIColor(named: "progressBarStatusColor") ?? .black)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
