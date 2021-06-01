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
        
        
        let getpoint2 = UIView()
        getpoint2.backgroundColor = .systemPink
        getpoint2.alpha = 0.2
        self.addSubview(getpoint2)
        
        editConstraint(getpoint, getpoint2)
    }
    func editConstraint(_ view2: UIView, _ view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor),
            view.heightAnchor.constraint(equalTo: view.superview!.heightAnchor, multiplier: 0.5),
            view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor, constant: -75),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.25),
            
            view2.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor),
            view2.heightAnchor.constraint(equalTo: view.superview!.heightAnchor, multiplier: 0.5),
            view2.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: 75),
            view2.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.25)
        ])
    }
}
