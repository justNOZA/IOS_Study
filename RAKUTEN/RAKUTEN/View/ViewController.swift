//
//  ViewController.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {

    lazy var active = ActivityIndicator(self)
    
    var libraryPretender = LibraryPretender()
    
    @IBOutlet weak var listTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //ActivityIndicator적용
        self.view.addSubview(active.indicator)

        
        active.indicator.startAnimating()
        
    }
}
