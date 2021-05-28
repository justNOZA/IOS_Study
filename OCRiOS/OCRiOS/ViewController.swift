//
//  ViewController.swift
//  OCRTest
//
//  Created by Pasonatech on 2021/05/18.
//

import UIKit
import VisionKit
import Photos
import TesseractOCR

class ViewController: UIViewController {

    var ocr = OCRReading()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var imageViewCollection: UIView!
    
    @IBAction func cameraReading(_ sender: Any) {
        clear(text: false)
        let alert = UIAlertController(title: "", message: "VNDocument?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "VsionKit", style: .default, handler: { action in
            self.scanDocument()
        }))
        alert.addAction(UIAlertAction(title: "UIPicker", style: .default, handler: {action in
            self.screenShot()
        }))

        self.present(alert, animated: true)
    }
    
    @IBAction func readImage(_ sender: Any) {
        clear()
        let alert = UIAlertController(title: "", message: "read by tesseract?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No Vsion", style: .default, handler: { action in
            self.readImagetoText()
        }))
        alert.addAction(UIAlertAction(title: "Yes Tesseract", style: .default, handler: {action in
            self.readImagetoText2()
        }))
        self.present(alert, animated: true)
        
    }
    
    @IBAction func nextPage(_ sender: Any) {
        self.performSegue(withIdentifier: "next", sender: nil)
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
            
            img.image = scan.imageOfPage(at: i)
            imageViewCollection.addSubview(img)
            plusContraint(img, CGFloat(i), wide)
        }
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //Handle properly error
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}

extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let wide = imageViewCollection.frame.width
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        setImage(input: image)
        img.image = getUIImage()
        
        imageViewCollection.addSubview(img)
        plusContraint(img, CGFloat(0), wide)
        self.dismiss(animated: true, completion: nil)
    }
    private func setImage(input:UIImage) {
        if let data = input.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("example.jpg")
            try? data.write(to: filename)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    private func getUIImage() -> UIImage?{
        let url = getDocumentsDirectory().appendingPathComponent("example.jpg")
        guard let data = try? Data(contentsOf: url) else {return nil}
        let image = UIImage(data: data)
        return image
    }
    private func getExample() -> UIImage? {
        guard let url = Bundle(for: type(of:self)).url(forResource: "example", withExtension: "jpg") else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        let image = UIImage(data: data)
        return image
    }
}

extension ViewController: G8TesseractDelegate{
    private func clear(text:Bool = true){
        if text {
            let num2 = textView.subviews.count
            for i in 0..<num2 {
                let sub = textView.subviews[i]
                sub.removeFromSuperview()
            }
        }else {
            let num = imageViewCollection.subviews.count
            for i in 0..<num {
                let sub = imageViewCollection.subviews[i]
                sub.removeFromSuperview()
            }
        }
    }
    
    private func screenShot(){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            // UIImagePickerController カメラを起動する
            present(picker, animated: true, completion: nil)
    }

    private func scanDocument() {
        let scanVC = VNDocumentCameraViewController()
        scanVC.delegate = self
        present(scanVC, animated: true)
    }
    
    private func readImagetoText(){
        let wide = textView.frame.width/CGFloat(imageViewCollection.subviews.count)
        for i in 0..<imageViewCollection.subviews.count{
            let value = UITextView()
            value.textContainer.maximumNumberOfLines = 100
            value.font = UIFont(name: "Callout", size: 12)
            
            let sub = imageViewCollection.subviews[i] as! UIImageView
            let image : UIImage? = sub.image?.preprocessedImage()
            value.text = ocr.ocrRequest(imageInput: image!)
            textView.addSubview(value)
            plusContraint(value, CGFloat(i), wide)
        }
    }
    private func readImagetoText2(){
        let wide = textView.frame.width/CGFloat(imageViewCollection.subviews.count)
        for i in 0..<imageViewCollection.subviews.count{
            let value = UITextView()
            value.textContainer.maximumNumberOfLines = 100
            value.font = UIFont(name: "Callout", size: 12)
            
            let sub = imageViewCollection.subviews[i] as! UIImageView
            let image : UIImage? = sub.image?.preprocessedImage()
            value.text = ocr.tesseractOCR(image: image, dg: self)
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
}
