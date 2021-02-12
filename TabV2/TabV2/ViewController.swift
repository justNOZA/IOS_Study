//
//  ViewController.swift
//  TabV2
//
//  Created by Pasonatech on 2021/02/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func TabCode(_ sender: Any) {
        guard let first =
                storyboard?.instantiateViewController(withIdentifier: "firstView") else{return}
        guard let second =
                storyboard?.instantiateViewController(withIdentifier: "secondView") else{return}
        guard let third =
                storyboard?.instantiateViewController(withIdentifier: "thirdView") else{return}
        
        let tb = UITabBarController()
        tb.setViewControllers([first, second, third], animated: true)
        tb.modalPresentationStyle = .fullScreen
        present(tb, animated: true, completion: nil)
    }
    
}

