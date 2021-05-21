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
    
    @IBAction func cameraReading(_ sender: Any) {
        scanDocument()
    }
  
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var imageViewCollection: UIView!
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
        // Here will be the code for text recognition
        controller.dismiss(animated: true)
        let wide = imageViewCollection.frame.width/CGFloat(scan.pageCount)
        for i in 0..<scan.pageCount{
            let img = UIImageView()
            let value = UITextView()
            value.textContainer.maximumNumberOfLines = 100
            value.font = UIFont(name: "Callout", size: 12)
            
            img.image = scan.imageOfPage(at: i)
            imageViewCollection.addSubview(img)
            plusContraint(img, CGFloat(i), wide)
            
            
            value.text = ocr.ocrRequest(imageInput: img.image!)
            textView.addSubview(value)
            plusContraint(value, CGFloat(i), wide)
            
        }
    }
    
    func plusContraint(_ view: UIImageView, _ num : CGFloat, _ wide : CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor, constant: 0),
            view.widthAnchor.constraint(equalToConstant: wide),
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: wide*num)
        ])
    }
    func plusContraint(_ view: UITextView, _ num : CGFloat, _ wide : CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor, constant: 0),
            view.widthAnchor.constraint(equalToConstant: wide),
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: wide*num),
        ])
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //Handle properly error
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}
//
////一般のカメラではできない
//extension ViewController:UIImagePickerControllerDelegate{
//
//
//    /// シャッターボタンを押下した際、確認メニューに切り替わる
//    /// - Parameters:
//    ///   - picker: ピッカー
//    ///   - info: 写真情報
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[.originalImage] as! UIImage
//        // UIImagePickerController カメラが閉じる
//        self.dismiss(animated: true, completion: nil)
//    }
//}
