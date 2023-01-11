//
//  ProgressBarVieww.swift
//  MacroChallenge
//
//  Created by Julia Alberti Maia on 12/07/22.
//

import UIKit

class ProgressBarView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var progressBar: PlainHorizontalProgressBar!
    @IBOutlet weak var progressBarStatus: PlainHorizontalProgressBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ProgressBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = .clear
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        progressBar.isAccessibilityElement = true
        progressBar.accessibilityLabel = NSLocalizedString("progressBar", comment: "")
    }
    
    func configProgressValue(value: CGFloat) {
        progressBarStatus.progress = value
        progressBar.accessibilityHint = "\(Int(value))" + NSLocalizedString("completion", comment: "")
        
    }
    
    func configProgressColors(progressBarColor: UIColor, progressBarStatusColor: UIColor) {
        progressBar.color = progressBarColor
        progressBarStatus.color = progressBarStatusColor
    }
    
}
