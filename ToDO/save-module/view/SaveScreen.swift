//
//  SaveScreen.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 05.12.22.
//

import UIKit

class SaveScreen: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    var savePresenter:ViewToPresenterSaveProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveRouter.createModule(ref: self)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if let name = tfName.text {
            savePresenter?.save(name: name)
        }
    }
    
    
}
