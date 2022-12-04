//
//  SaveRouter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

class SaveRouter : PresenterToRouterSaveProtocol{
    static func createModule(ref: SaveScreen) {
        //View
        ref.savePresenter = SavePresenter()
        
        //Presenter
        ref.savePresenter?.saveInteractor = SaveInteractor()
    }
}
