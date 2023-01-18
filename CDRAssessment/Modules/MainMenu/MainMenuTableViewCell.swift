//
//  MainMenuTableViewCell.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 17/01/23.
//

import UIKit

protocol MainMenuDelegate: AnyObject {
    func didTapReferenceButton()
    func didTapStartButton()
    func didTapRemoveAdsButton()
}

class MainMenuTableViewCell: UITableViewCell {

    weak var delegate: MainMenuDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var removeAdsView: UIView!
    @IBOutlet weak var removeAdsButton: UIButton!
    @IBOutlet weak var removeAdsLabel: UILabel!
    @IBOutlet weak var referenceButton: UIButton!

    @IBOutlet weak var externalView: UIView!
    @IBOutlet weak var internalView: UIView!
    
    @IBAction func startAction(_ sender: UIButton) {
        delegate?.didTapStartButton()
    }
    
    @IBAction func referenceAction(_ sender: UIButton) {
        delegate?.didTapReferenceButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        titleLabel.text = NSLocalizedString("title", comment: "")
        subtitleLabel.text = NSLocalizedString("subtitle", comment: "")
        referenceButton.setTitle(NSLocalizedString("reference", comment: ""), for: .normal)
        removeAdsLabel.text = NSLocalizedString("removeAds", comment: "")
        
        let border = CAShapeLayer()
        border.strokeColor = UIColor.orange.cgColor
        border.lineDashPattern = [6, 3]
        border.frame = internalView.bounds
        border.fillColor = nil
        border.path = UIBezierPath(ovalIn: internalView.bounds).cgPath
        internalView.layer.addSublayer(border)
        
        externalView.layer.cornerRadius = externalView.frame.height / 2
        internalView.layer.cornerRadius = internalView.frame.height / 2
        
        externalView.layer.shadowColor = UIColor.black.cgColor
        externalView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        externalView.layer.shadowOpacity = 0.5
        externalView.layer.shadowRadius = 5.0
        
        startButton.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        startButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
        startButton.titleLabel?.layer.shadowOpacity = 0.7
        startButton.titleLabel?.layer.shadowRadius = 0
        removeAdsView.layer.cornerRadius = removeAdsView.frame.height / 2
        removeAdsView.removeFromSuperview()
    }

}
