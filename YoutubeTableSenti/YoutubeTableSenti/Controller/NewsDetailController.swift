//
//  NewsDetailController.swift
//  YoutubeTableSenti
//
//  Created by Pasonatech on 2021/02/24.
//

import UIKit

class NewsDetailController: UIViewController {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var labelMain: UILabel!
    
    var imageUrl: String?
    var descriptionNews: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = imageUrl{
           if let data = try? Data(contentsOf: URL(string: img)!) {
                DispatchQueue.main.async {
                    self.imageMain.image = UIImage(data: data)
                }
            }
        }
        if let desc = descriptionNews{
            self.labelMain.text = desc
        }
    }

}
