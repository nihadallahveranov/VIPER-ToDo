//
//  HomeProtocols.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 04.12.22.
//

import Foundation

// main protocols
protocol ViewToPresenterHomeProtocol {
    var homeInteractor: PresenterToInteractorHomeProtocol? {get set}
    var homeView: PresenterToViewHomeProtocol? {get set}
    
    func loadTodos()
    func search(searchText: String)
    func delete(id: Int)
    
    func loadDates()
    func searchWithDay(day: String)
}

protocol PresenterToInteractorHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol? {get set}
    
    func loadTodos()
    func search(searchText: String)
    func delete(id: Int)
    
    func loadDates()
    func searchWithDay(day: String)
}


// carrier protocols
protocol InteractorToPresenterHomeProtocol {
    func sendToPresenter(todoList: [ToDo])
    func sendToPresenter(dateList: [String])
}

protocol PresenterToViewHomeProtocol {
    func sendToView(todoList: [ToDo])
    func sendToView(dateList: [String])
}


// router protocol
protocol PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeScreen)
}
