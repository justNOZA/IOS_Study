//
//  ViewController.swift
//  FirstPractice
//
//  Created by Pasonatech on 2021/02/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Greet.text = NSLocalizedString("Labelname", comment: "")
        

    }

    @IBAction func ClickChangeBtn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var Greet: UILabel!
    
}
/*
extension UILabel{
    @IBInspectable
    private var locallizedKey:String?{
        get {
            fatalError("Only set this value")
        }
        set{
            if let newValue = newValue{
                text = newValue.localized()
                
            }
        }
    }
}

extension String {
    private static let localizedEmptyKey = "##not exists##"
    func localized() -> String {
        let string = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: String.localizedEmptyKey, comment: "")
        if string == String.localizedEmptyKey {
            fatalError("not exists localized key")
        }
        return string
    }

}
*/
