//
//  HomeRouter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 04.12.22.
//

import Foundation

class HomeRouter: PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeScreen) {
        let presenter = HomePresenter()
        
        //View
        ref.homePresenterObject = presenter
        
        //Presenter
        ref.homePresenterObject?.homeInteractor = HomeInteractor()
        ref.homePresenterObject?.homeView = ref
        
        //Interactor
        ref.homePresenterObject?.homeInteractor?.homePresenter = presenter
    }
    
    
}
