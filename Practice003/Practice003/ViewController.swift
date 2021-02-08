//
//  ViewController.swift
//  Practice003
//
//  Created by Pasonatech on 2021/02/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // LocalL.text = NSLocalizedString("Hello", comment: "")
        // LocalL.text = "Hello".localized
    }
    @IBOutlet weak var LocalL: UILabel!
    
    @IBOutlet weak var ChgBtn: UIButton!
    @IBAction func ChgBtn(_ sender: Any) {
    }
}

extension UILabel {
    @IBInspectable
    private var localizedKey: String? {
        get { fatalError("only set this value") }
        set {
            if let newValue = newValue {
                text = newValue.localized()
            }
        }
    }
}
extension UIButton {
    @IBInspectable
    private var localizedKey: String? {
        get { fatalError("only set this value") }
        set {
            if let newValue = newValue {
                titleLabel?.text = newValue.localized()
            }
        }
    }
}
extension String {
    func localized() -> String? {
        return NSLocalizedString(self, comment: "")
    }
}

/*
extension String {

     var localized: String {
           return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
        }
}
*/
