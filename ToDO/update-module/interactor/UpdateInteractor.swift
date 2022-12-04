//
//  UpdateInteractor.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import Foundation

class UpdateInteractor: PresenterToInteractorUpdateProtocol {
    
    let db:FMDatabase?
    
    init(){
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = URL(fileURLWithPath: databasePath).appendingPathComponent("todo.sqlite")
        db =  FMDatabase(path: destinationPath.path)
    }
    
    func update(id: Int, name: String) {
        db?.open()
        
        do {
            try db?.executeUpdate("UPDATE tasks SET name = ? WHERE id = ?", values: [name, id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }

}
