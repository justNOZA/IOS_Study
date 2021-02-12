//
//  First.swift
//  TabV2
//
//  Created by Pasonatech on 2021/02/12.
//

import UIKit

class First: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveSecond(_ sender: Any) {
        guard let second = tabBarController?.viewControllers?[1] else{return}
        tabBarController?.selectedViewController = second
    }
    
    @IBAction func moveThird(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
