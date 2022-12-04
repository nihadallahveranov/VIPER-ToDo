//
//  SavePresenter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

class SavePresenter: ViewToPresenterSaveProtocol {
    var saveInteractor: PresenterToInteractorSaveProtocol?
    
    func save(name: String) {
        saveInteractor?.save(name: name)
    }
    
    
}
