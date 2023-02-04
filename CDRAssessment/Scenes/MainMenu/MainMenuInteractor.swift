//
//  MainMenuInteractor.swift
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

protocol MainMenuBusinessLogic
{
    func fetchTexts(request: MainMenu.FetchTexts.Request)
}

protocol MainMenuDataStore
{
    var texts: [String]? { get }
}

class MainMenuInteractor: MainMenuBusinessLogic, MainMenuDataStore
{
    
    var presenter: MainMenuPresentationLogic?
    var worker: MainMenuWorker?
    var texts: [String]?
    
    // MARK: Do something
    
    func fetchTexts(request: MainMenu.FetchTexts.Request) {
        worker = MainMenuWorker()
        worker?.fetchTexts { (texts) -> Void in
            self.texts = texts
            let response = MainMenu.FetchTexts.Response(texts: texts)
            self.presenter?.presentTexts(response: response)
          }
    }
}