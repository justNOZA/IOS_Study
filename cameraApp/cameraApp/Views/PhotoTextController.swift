//
//  PhotoText.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit

class PhotoTextController : UIViewController {
    
    @IBOutlet weak var photoText: UILabel!
    var imageData : UIImage?
    var ocr = OCRReading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readImagetoText()
    }
    
    private func readImagetoText(){
        if let data = imageData {
            photoText.text = ocr.ocrRequest(image: data)
        } else {
            photoText.text = "picture first"
        }
    }
}
