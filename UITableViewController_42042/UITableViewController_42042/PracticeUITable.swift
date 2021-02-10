//
//  PracticeUITable.swift
//  UITableViewController_42042
//
//  Created by Pasonatech on 2021/02/10.
//

import UIKit

class PracticeUITable:UITableViewController{

    var list:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...100{
            list.append(i)
        }
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellTest", for : indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        return cell
    }
    
    
}
