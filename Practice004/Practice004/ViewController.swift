//
//  ViewController.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        print(CBtn.titleLabel)
        CBtn.titleLabel?.text = "aa"
        print(CBtn.titleLabel)
        */
        //print(Greet)
        //Greet.text = "aa"
        //print(Greet.text)
        //CBtn.setTitle("aa", for: UIControl.State.normal)
        
        
        // Greet.text = NSLocalizedString(“Hello”, comment: “”)
        // Greet.text = “Hello”.localized
        
//        view.backgroundColor = .secondarySystemBackground
 /*
        switch traitCollection.userInterfaceStyle {
        case .dark:
            myView.backgroundColor = .systemPurple
            Greet.textColor = .white
            CBtn.setTitleColor(.white, for: UIControl.State.normal)
        case .light:
            myView.backgroundColor = .brown
            Greet.textColor = .black
            CBtn.setTitleColor(.black, for: UIControl.State.normal)
        default:
            print("Dont select")
        }
 */
        //myView.backgroundColor = .
    }
  //  @IBOutlet weak var ModeImg: UIImageView!
    @IBOutlet weak var Greet: UILabel!
    
//오늘은 정말 커밋 많이함
    @IBAction func CBtn(_ sender: Any) {
        /*
        Greet.text = NSLocalizedString("Hello1", comment: "")
        CBtn.setTitle(NSLocalizedString("Button", comment: ""), for: UIControl.State.normal)
        */
        Greet.localizedKey = "Hello1"
        CBtn.localizedKey = "Button"
        
    }
 //   @IBOutlet weak var myView: UIView!
    @IBOutlet weak var CBtn: UIButton!
}

/*
 extension String {
    var localized: String {
       return NSLocalizedString(self, tableName: “Localizable”, value: self, comment: “”)
     }
 }
 */



