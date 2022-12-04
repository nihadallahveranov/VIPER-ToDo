//
//  SaveProtocols.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

protocol ViewToPresenterSaveProtocol {
    var saveInteractor: PresenterToInteractorSaveProtocol? {get set}
    
    func save(name: String)
}

protocol PresenterToInteractorSaveProtocol {
    func save(name: String)
}

protocol PresenterToRouterSaveProtocol {
    static func createModule(ref: SaveScreen)
}
