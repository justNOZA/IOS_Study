//
//  LibDetailView.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/26.
//

import UIKit

class LibDetailView: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailAuthor: UILabel!
    @IBOutlet weak var detailPublisher: UILabel!
    @IBOutlet weak var detailCaption: UILabel!
    
    var img : String?
    var author : String?
    var publisher : String?
    var bookTitle: String?
    var caption : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookImage = img {
            if let data = try? Data(contentsOf: URL(string: bookImage)!) {
                DispatchQueue.main.async {
                    self.detailImage.image = UIImage(data: data)
                }
            }
        }
        if let content = author {
            self.detailAuthor.text = content
        }
        if let content = publisher {
            self.detailPublisher.text = content
        }
        if let content = caption {
            self.detailCaption.text = content
        }
        if let content = bookTitle {
            self.detailTitle.text = content
        }
    }
    

}
