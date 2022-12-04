//
//  UpdateScreen.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 04.12.22.
//

import UIKit

class UpdateScreen: UIViewController {

    var todo: ToDo?
    var updatePresenter: ViewToPresenterUpdateProtocol?
    
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UpdateRouter.createModule(ref: self)
        
        if let td = todo {
            tfName.text = td.name
        }
    }

    @IBAction func btnUpdate(_ sender: Any) {
        if let name = tfName.text, let td = todo {
            updatePresenter?.update(id: td.id!, name: name)
        }
    }
}
