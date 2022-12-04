//
//  HomeScreen.swift
//  ToDO
//
//  Created by Nihad Allahveranov on 30.11.22.
//

import UIKit

class HomeScreen: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var todoCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoList = [ToDo]()
    var dateList = [String]()
    
    var homePresenterObject:ViewToPresenterHomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoCollectionView.delegate = self
        todoCollectionView.dataSource = self
        todoTableView.delegate = self
        todoTableView.dataSource = self
        searchBar.delegate = self
        
        HomeRouter.createModule(ref: self)
        
        copyDatabase()
        
        homePresenterObject?.loadDates()
        
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: 96, height: self.todoCollectionView.frame.size.height - 10)
        layout.scrollDirection = .horizontal
        
        todoCollectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenterObject?.loadTodos()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdate" {
            if let todo = sender as? ToDo {
                let updateScreen = segue.destination as! UpdateScreen
                updateScreen.todo = todo
            }
        }
    }
    
    func copyDatabase(){
        let bundle = Bundle.main.path(forResource: "todo", ofType: ".sqlite")
        
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let destinationPath = URL(fileURLWithPath: databasePath).appendingPathComponent("todo.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: destinationPath.path) {
            print("There is a database")
        } else{
            do {
                try fm.copyItem(atPath: bundle!, toPath: destinationPath.path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension HomeScreen : PresenterToViewHomeProtocol {
    func sendToView(dateList: [String]) {
        self.dateList = dateList
        self.todoCollectionView.reloadData()
    }
    
    func sendToView(todoList: [ToDo]) {
        self.todoList = todoList
        self.todoTableView.reloadData()
    }
}


extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let date = dateList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
    
        cell.lblWeekDay.text = String(date.split(separator: " ")[0])
        cell.lblDay.text = String(date.split(separator: " ")[1])
        
        if indexPath[1] == 0 {
            cell.layer.backgroundColor = UIColor(named: "mainColor")?.cgColor
        }
        
        cell.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 15
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.todoCollectionView)
        let indexPath = self.todoCollectionView.indexPathForItem(at: location)
        
        if let indexs = indexPath {
            let lbl = self.todoCollectionView.cellForItem(at: indexs)?.viewWithTag(9) as? UILabel
            
            if let day = lbl?.text {
                homePresenterObject?.searchWithDay(day: day)
            }
            
            self.todoCollectionView.cellForItem(at: indexs)?.backgroundColor = UIColor(named: "mainColor")
            
            for i in 0...self.todoCollectionView.numberOfItems(inSection: 0) {
                if i != indexs[1] {
                    let color: UIColor
                    if self.traitCollection.userInterfaceStyle == .dark {
                        color = UIColor.black
                    } else {
                        color = UIColor.white
                    }
                    
                    self.todoCollectionView.cellForItem(at: NSIndexPath(item: i, section: 0) as IndexPath)?.backgroundColor = color
                }
            }
        }
    }

}

extension HomeScreen : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homePresenterObject?.search(searchText: searchText)
    }
}


extension HomeScreen : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! ToDoViewCell
        
        cell.lblName.text = "\(todo.name!)"
        cell.lblDate.text = "\(todo.date!)"
        cell.layer.cornerRadius = 32
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.75
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        performSegue(withIdentifier: "toUpdate", sender: todo)
        print("success")
        todoTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action,view,bool) in
            let todo = self.todoList[indexPath.row]

            let alert = UIAlertController(title: "Deletion Process", message: "Do you want to delete \(todo.name!) ?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)

            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.homePresenterObject?.delete(id: todo.id!)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)

        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

