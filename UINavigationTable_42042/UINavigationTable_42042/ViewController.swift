//
//  ViewController.swift
//  UINavigationTable_42042
//
//  Created by Pasonatech on 2021/02/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NaviAction(_ sender: Any) {
        if let move = self.storyboard?.instantiateViewController(withIdentifier: "naviPage"){
            self.navigationController?.pushViewController(move, animated: true)
        }
    }
    
}

