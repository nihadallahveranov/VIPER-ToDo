//
//  UpdateRouter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

class UpdateRouter: PresenterToRouterUpdateProtocol {
    static func createModule(ref: UpdateScreen) {
        //View
        ref.updatePresenter = UpdatePresenter()
        //Presenter
        ref.updatePresenter?.updateInteractor = UpdateInteractor()
    }
}
