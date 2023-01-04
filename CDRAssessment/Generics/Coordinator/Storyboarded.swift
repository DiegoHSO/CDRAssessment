//
//  Storyboarded.swift
//  MacroChallenge
//
//  Created by Diego Henrique Silva Oliveira on 21/07/22.
//

import UIKit

//
// MARK: - Storyboarded
//

protocol Storyboarded {
    static func instantiate(_ storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(_ storyboard: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        
        // swiftlint:disable force_cast 
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
