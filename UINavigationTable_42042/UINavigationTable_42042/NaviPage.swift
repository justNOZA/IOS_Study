//
//  NaviPage.swift
//  UINavigationTable_42042
//
//  Created by Pasonatech on 2021/02/10.
//

import UIKit

class NaviPage : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.topItem?.title = "HAPPY"
        navigationController?.navigationBar.backItem?.title = "Back"
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]

        let rightBarButton = UIBarButtonItem.init(title: "right", style: .done, target: self, action: nil)
                navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.tintColor = .green
    }
    
}
