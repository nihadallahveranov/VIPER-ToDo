//
//  SaveInteractor.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

class SaveInteractor: PresenterToInteractorSaveProtocol {
    
    let db:FMDatabase?
    
    init(){
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = URL(fileURLWithPath: databasePath).appendingPathComponent("todo.sqlite")
        db =  FMDatabase(path: destinationPath.path)
    }
    
    func save(name: String) {
        db?.open()
        
        do {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: Date())
            
            if let day = components.day, let month = components.month, let year = components.year {
                let date = "\(day)/\(month)/\(year)"
                print(date)
                try db!.executeUpdate("INSERT INTO tasks (name,date) VALUES (?,?)", values: [name,date])
                
                print("successfully")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
}
