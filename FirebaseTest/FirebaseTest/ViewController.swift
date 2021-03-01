//
//  ViewController.swift
//  BoostCampInterview
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    
    var todos = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel!.text = self.todos[indexPath.row]
        return cell
    }

    @IBAction func addTodo(_ sender: Any) {
        let dialog = UIAlertController(title: "새 할일 추가", message: nil, preferredStyle: .alert)
        dialog.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { (action : UIAlertAction) in
            if let newTodo = dialog.textFields?[0].text {
                print("입력할 할일 : \(newTodo)")
                self.todos.append(newTodo)
                self.tableView.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        self.show(dialog, sender: nil)
    }
}

