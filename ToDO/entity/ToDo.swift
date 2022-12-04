//
//  ToDo.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 03.12.22.
//

import Foundation

class ToDo {
    var id: Int?
    var name: String?
    var date: String?
    
    init(id: Int, name: String, date: String){
        self.id = id
        self.name = name
        self.date = date
    }
}
