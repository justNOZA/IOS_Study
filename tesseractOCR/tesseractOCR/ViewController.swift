//
//  ViewController.swift
//  OCRTest
//
//  Created by Pasonatech on 2021/05/18.
//

import UIKit
import VisionKit
import Photos

class ViewController: UIViewController/*, UINavigationControllerDelegate*/ {
    let ocr = OCRaction()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraReading(_ sender: Any) {
        addAction()
    }
    @IBOutlet weak var textIn: UILabel!
    @IBOutlet weak var allText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func img(_ sender: Any) {
        allText.text = ocr.ocrReading()
    }
    func addAction(){
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        self.present(imagePicker, animated: true, completion: nil)
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
        textIn.text = ocr.ocrActing(scan.imageOfPage(at: 0))
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
////一般のカメラではできないd
//extension ViewController:UIImagePickerControllerDelegate{
//
//    /// シャッターボタンを押下した際、確認メニューに切り替わる
//    /// - Parameters:
//    ///   - picker: ピッカー
//    ///   - info: 写真情報
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[.originalImage] as! UIImage
//        imageView.image = image
//        textIn.text = ocr.ocrActing(image)
//        // UIImagePickerController カメラが閉じる
//        self.dismiss(animated: true, completion: nil)
//    }
//}
