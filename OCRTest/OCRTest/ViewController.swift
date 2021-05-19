//
//  ViewController.swift
//  OCRTest
//
//  Created by Pasonatech on 2021/05/18.
//

import UIKit
import VisionKit
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate {

    var ocr = OCRReading()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func show(_ sender: Any) {
//        textIn.text = ocr.ocrRequest()
    }
    
    @IBAction func cameraReading(_ sender: Any) {
        scanDocument()
    }
    @IBOutlet weak var textIn: UILabel!
    @IBOutlet weak var allText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
//    @IBAction func normalCameraMode(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.sourceType = .camera
//        picker.delegate = self
//        // UIImagePickerController カメラを起動する
//        present(picker, animated: true, completion: nil)
//    }
    private func scanDocument() {
        let scanVC = VNDocumentCameraViewController()
        scanVC.delegate = self
        present(scanVC, animated: true)
    }
}

extension ViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        imageView.image = scan.imageOfPage(at: 0)
        (textIn.text, allText.text) = ocr.ocrRequest(imageInput: scan.imageOfPage(at: 0))
        // Here will be the code for text recognition
 
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //Handle properly error
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}

//一般のカメラではできない
extension ViewController:UIImagePickerControllerDelegate{
    
    
    /// シャッターボタンを押下した際、確認メニューに切り替わる
    /// - Parameters:
    ///   - picker: ピッカー
    ///   - info: 写真情報
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        (textIn.text, allText.text) = ocr.ocrRequest(imageInput: image)
        // UIImagePickerController カメラが閉じる
        self.dismiss(animated: true, completion: nil)
    }
}
