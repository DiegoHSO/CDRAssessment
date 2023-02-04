//
//  MainMenuWorker.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 03/02/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MainMenuWorker {
    func fetchTexts(completionHandler: @escaping ([String]) -> Void) {
        completionHandler([NSLocalizedString("title", comment: ""),
                NSLocalizedString("subtitle", comment: ""),
                NSLocalizedString("start", comment: ""),
                NSLocalizedString("reference", comment: ""),
                "https://knightadrc.wustl.edu/professionals-clinicians/cdr-dementia-staging-instrument/cdr-scoring-rules/",
                NSLocalizedString("removeAds", comment: "")
        ])
    }
}
