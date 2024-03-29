//
//  PlainHorizontalProgressBar.swift
//  ProgrssBars
//
//  Created by Marina on 09/05/2020.
//  Copyright © 2020 Marina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PlainHorizontalProgressBar: UIView {
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }
    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    private let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        gradient.cornerRadius = 21
        gradient.colors = [UIColor(named: "firstGradientColor")!.cgColor, UIColor(named: "secondGradientColor")!.cgColor]
        progressLayer.addSublayer(gradient)
        self.layer.cornerRadius = 21
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        gradient.frame = progressRect
    }
}
