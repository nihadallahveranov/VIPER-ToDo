//
//  UpdatePresenter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation


class UpdatePresenter: ViewToPresenterUpdateProtocol {
    var updateInteractor: PresenterToInteractorUpdateProtocol?
    
    func update(id: Int, name: String) {
        updateInteractor?.update(id: id, name: name)
    }
}
