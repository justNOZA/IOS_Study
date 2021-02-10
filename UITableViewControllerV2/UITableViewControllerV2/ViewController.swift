//
//  ViewController.swift
//  UITableViewControllerV2
//
//  Created by Pasonatech on 2021/02/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list : [Int] = []
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1...100{
            list.append(i)
        }
        
        testTableView.delegate = self
        testTableView.dataSource = self
    }
    //row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //delete
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for : indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        cell.textLabel?.textAlignment = .center
        return cell
    }
    //connect
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    //add
    @IBAction func AddNumer(_ sender: UIBarButtonItem) {
        let alertC = UIAlertController(title: "Additional Number", message: "Number to Add", preferredStyle: .alert)
        alertC.addTextField { (texfield) in
            texfield.placeholder = "Enter Numeric"
        }
        let confirmAct = UIAlertAction(title: "Check", style: .default) {
            _ in
            let textField = alertC.textFields![0]
            if let newNumber = textField.text, newNumber != "", Int(newNumber) != nil {
                self.list.append(Int(newNumber)!)
                let indexP = IndexPath(row: self.list.count-1, section:0)
                self.testTableView.insertRows(at: [indexP], with: UITableView.RowAnimation.automatic)
            }
        }
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel){ _ in
        }
        alertC.addAction(confirmAct)
        alertC.addAction(cancelAct)
        self.present(alertC, animated: true, completion: nil)
    }
    
    //delete num
    @IBAction func EditNum(_ sender: UIBarButtonItem) {
        if testTableView.isEditing{
            sender.title = "Edit"
            testTableView.setEditing(false, animated: true)
        }
        else{
            sender.title = "Done"
            testTableView.setEditing(true, animated: true)
        }
    }
    
    
    //moving _v Simple
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
}

