/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app's photo capture delegate object.
*/

import AVFoundation
import Photos
import UIKit
class PhotoCaptureProcessor: NSObject {
    private(set) var requestedPhotoSettings: AVCapturePhotoSettings
    
    private let willCapturePhotoAnimation: () -> Void
    
    lazy var context = CIContext()
    
    private let completionHandler: (PhotoCaptureProcessor, UIImage?, UIImage?) -> Void
    
    private let photoProcessingHandler: (Bool) -> Void
    
    private var photoData: Data?
    
    private var maxPhotoProcessingTime: CMTime?
    
    private var img: UIImage?
    private var img2: UIImage?
    
    private var point: UIView?
//    private var origin: CGRect?
    
    init(with requestedPhotoSettings: AVCapturePhotoSettings,
         willCapturePhotoAnimation: @escaping () -> Void,
         completionHandler: @escaping (PhotoCaptureProcessor, UIImage?, UIImage?) -> Void,
         photoProcessingHandler: @escaping (Bool) -> Void,
         point: UIView) {
        self.requestedPhotoSettings = requestedPhotoSettings
        self.willCapturePhotoAnimation = willCapturePhotoAnimation
        self.completionHandler = completionHandler
        self.photoProcessingHandler = photoProcessingHandler
        self.point = point
    }
    private func didFinish() {
        //check
        completionHandler(self, img, img2)
    }
}

extension PhotoCaptureProcessor: AVCapturePhotoCaptureDelegate {
    /*
     This extension adopts all of the AVCapturePhotoCaptureDelegate protocol methods.
     */
    
    /// - Tag: WillBeginCapture
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        maxPhotoProcessingTime = resolvedSettings.photoProcessingTimeRange.start + resolvedSettings.photoProcessingTimeRange.duration //check
    }
    
    /// - Tag: WillCapturePhoto
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        willCapturePhotoAnimation()
        //check
        guard let maxPhotoProcessingTime = maxPhotoProcessingTime else {
            return
        }
        
        // Show a spinner if processing time exceeds one second.
        let oneSecond = CMTime(seconds: 1, preferredTimescale: 1)
        if maxPhotoProcessingTime > oneSecond {
            photoProcessingHandler(true)
        }
    }
    
    
    /// - Tag: DidFinishProcessingPhoto
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        photoProcessingHandler(false)
        //check
        if let error = error {
            print("Error capturing photo: \(error)")
        } else {
            photoData = photo.fileDataRepresentation()
            let image = UIImage(data: photoData!)
            (img, img2) = cropImage2(image: image!)
        }
    }
    
    /// - Tag: DidFinishCapture
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        //check
        if let error = error {
            print("Error capturing photo: \(error)")
            didFinish()
            return
        }
        
        didFinish()
    }
    
    func cropImage2(image: UIImage) -> (UIImage?, UIImage?) {
        let rect1 = point!.subviews[0].frame
        let rect2 = point!.subviews[1].frame
        let scale = point!.frame.width/image.size.width
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect1.size.width / scale, height: rect1.size.height / scale), true, 0.0)
        image.draw(at: CGPoint(x: -rect1.origin.x / scale, y: -rect1.origin.y / scale))
        let croppedImage1 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect2.size.width / scale, height: rect2.size.height / scale), true, 0.0)
        image.draw(at: CGPoint(x: -rect2.origin.x / scale, y: -rect2.origin.y / scale))
        let croppedImage2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let ocr = OCRReading()
        print(ocr.ocrRequest(image: croppedImage1!))
        print(ocr.ocrRequest(image: croppedImage2!))
// 여기서 바로 읽어내는 것도 가능
        return (croppedImage1, croppedImage2)
    }
}
