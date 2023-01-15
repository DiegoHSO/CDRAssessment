//
//  CategoryTableViewCell.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 11/01/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "categoryCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
