//
//  UpdateProtocols.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

protocol ViewToPresenterUpdateProtocol {
    var updateInteractor: PresenterToInteractorUpdateProtocol? {get set}
    
    func update(id: Int, name: String)
}

protocol PresenterToInteractorUpdateProtocol {
    func update(id: Int, name: String)
}

protocol PresenterToRouterUpdateProtocol {
    static func createModule(ref: UpdateScreen)
}
