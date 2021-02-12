//
//  ViewController.swift
//  FileDownload
//
//  Created by Pasonatech on 2021/02/12.
//

import UIKit

class ViewController: UIViewController {
    
    var practices = [String:Any]()
    var imgUrl:String = ""
//    var jsonTest: [Test] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        let jsonDecoder : JSONDecoder = JSONDecoder()
//        guard let dataAsset: NSDataAsset = NSDataAsset.init(name: "jsonPractice") else{return}
//        do {
//            self.jsonTest = try jsonDecoder.decode([Test ].self, from: dataAsset.data)
//        }catch{
//            print(error.localizedDescription)
//        }
//        print(jsonTest)
//
        
        let path = Bundle.main.path(forResource: "jsonPractice", ofType: "json")
        if let data = try? String(contentsOfFile: path!).data(using: .utf8){
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            as! [String:Any]
            practices = json
        }
        if let test = practices["results"] as? [[String:Any]]{
            imgUrl = test[0]["artworkUrl60"] as! String
        }
    }

    let checkTitle = "WARNING!"
    let checkMessage = "Do you want download it?"

    @IBAction func Check(_ sender: Any) {
        let check = UIAlertController(title: checkTitle, message: checkMessage, preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "YES", style: .default){
            _ in
            let url = URL(string:self.imgUrl)
            do{
                let data = try Data(contentsOf: url!)
                self.ImageView.image = UIImage(data: data)
            }catch{
                print("I'm Sorry")
            }
        }
        let rejectAction = UIAlertAction(title: "Cancle", style:.cancel)
        check.addAction(confirmAction)
        check.addAction(rejectAction)
        self.present(check, animated: true, completion: nil)
    }
    @IBOutlet weak var ImageView: UIImageView!
}

