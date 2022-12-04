//
//  HomePresenter.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 04.12.22.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteractorHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?

    func loadTodos() {
        homeInteractor?.loadTodos()
    }

    func search(searchText: String) {
        homeInteractor?.search(searchText: searchText)
    }

    func delete(id: Int) {
        homeInteractor?.delete(id: id)
    }
    
    func loadDates() {
        homeInteractor?.loadDates()
    }
    
    func searchWithDay(day: String) {
        homeInteractor?.searchWithDay(day: day)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func sendToPresenter(dateList: [String]) {
        homeView?.sendToView(dateList: dateList)
    }
    
    func sendToPresenter(todoList: [ToDo]) {
        homeView?.sendToView(todoList: todoList)
    }
}
