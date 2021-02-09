//
//  PresentVT.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/09.
//

import UIKit

class PresentVT:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackHome(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
