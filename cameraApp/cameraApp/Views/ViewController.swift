//
//  ViewController.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoView: UIView!
    @IBAction func photoOn(_ sender: Any) {
        self.performSegue(withIdentifier: toView.camera.rawValue, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ocrImage)))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? CamViewController{
            svc.datasend = self
        }
    }
    @objc func ocrImage(){
        let modalViewController = storyboard?.instantiateViewController(identifier: "PhotoTextController") as! PhotoTextController
        if photoView.subviews.count != 0, let data = photoView.subviews[0] as? UIImageView{
            modalViewController.imageData = data.image
        }
        present(modalViewController, animated: true, completion: nil)
    }
    
    func deleteImage(){
        if photoView.subviews.count != 0 {
            photoView.subviews[0].removeFromSuperview()
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
    func combineImage(_ firstImage:UIImage?, _ secondImage:UIImage?) -> UIImage?{
        let size = CGSize(width: firstImage!.size.width+secondImage!.size.width, height: firstImage!.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        firstImage!.draw(in: CGRect(x: 0, y: 0, width: firstImage!.size.width, height: size.height))
        secondImage!.draw(in: CGRect(x: firstImage!.size.width, y: 0, width: secondImage!.size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
extension ViewController : PhotoData{
    func getData(image: UIImage?, image2: UIImage?) {
        let result = combineImage(image, image2)
        deleteImage()
        if let pd = result {
            let wide = photoView.frame.width
            let img = UIImageView()
            img.contentMode = .scaleAspectFit
            img.image = pd
            photoView.addSubview(img)
            plusContraint(img, CGFloat(0), wide)
        }
    }
    
}

protocol PhotoData {
    func getData(image: UIImage?, image2:UIImage?)
}

