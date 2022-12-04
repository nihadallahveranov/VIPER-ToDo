//
//  HomeInteractor.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 03.12.22.
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {
    
    var homePresenter: InteractorToPresenterHomeProtocol?

    let db:FMDatabase?
    
    init(){
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = URL(fileURLWithPath: databasePath).appendingPathComponent("todo.sqlite")
        db =  FMDatabase(path: destinationPath.path)
    }
    
    func loadTodos() {
        var todoList = [ToDo]()
        
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM tasks", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let date = result.string(forColumn: "date")!
                
                let todo = ToDo(id: id, name: name, date: date)
                todoList.append(todo)
            }
            
            homePresenter?.sendToPresenter(todoList: todoList)
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(id: Int) {
        db?.open()
        
        do {
            try db?.executeUpdate("DELETE FROM tasks WHERE id = ?", values: [id])
            loadTodos()
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(searchText: String) {
        db?.open()
        
        var todoList = [ToDo]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM tasks WHERE name like ?", values: ["%\(searchText)%"])
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let date = result.string(forColumn: "date")!
                
                let todo = ToDo(id: id, name: name, date: date)
                todoList.append(todo)
            }
            
            homePresenter?.sendToPresenter(todoList: todoList)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadDates() {
        var dateList = [String]()
        
        let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components([.weekday, .day], from: Date()) as NSDateComponents
        
        for i in 0 ... 6 {
            let date = "\(weekDays[(components.weekday - 1 + i) % 7]) \(components.day + i)"
            
            dateList.append(date)
        }
        
        homePresenter?.sendToPresenter(dateList: dateList)
    }
    
    func searchWithDay(day: String) {
        db?.open()
        
        var todoList = [ToDo]()
        
        do{
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: Date())
            
            if let month = components.month, let year = components.year {
                let date = "\(day)/\(month)/\(year)"
                
                let result = try db!.executeQuery("SELECT * FROM tasks WHERE date = ?", values: [date])
                
                while result.next() {
                    let id = Int(result.string(forColumn: "id"))!
                    let name = result.string(forColumn: "name")!
                    let date = result.string(forColumn: "date")!
                    
                    let todo = ToDo(id: id, name: name, date: date)
                    todoList.append(todo)
                }
            }
            
            homePresenter?.sendToPresenter(todoList: todoList)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
}
