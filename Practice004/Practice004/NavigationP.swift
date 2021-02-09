//
//  NavigationP.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/09.
//

import UIKit

class NavigationP : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Back1(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
