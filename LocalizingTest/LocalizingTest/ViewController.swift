//
//  ViewController.swift
//  LocalizingTest
//
//  Created by Pasonatech on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        helloLabel.text = NSLocalizedString("Hello", comment: "")
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

extension String {
    func localized() -> String? {
        return NSLocalizedString(self, comment: "")
    }
}
