import UIKit
import AVFoundation

class PreviewView: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        setGetPoint()
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    private func setGetPoint(){
        let getpoint = UIView()
        getpoint.backgroundColor = .systemPink
        getpoint.alpha = 0.2
        self.addSubview(getpoint)
        editConstraint(getpoint)
    }
    func editConstraint(_ view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor),
            view.heightAnchor.constraint(equalTo: view.superview!.heightAnchor, multiplier: 0.5),
            view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor, constant: -50),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.25)
        ])
    }
}
