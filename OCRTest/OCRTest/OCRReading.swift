//
//  OCRReading.swift
//  OCRTest
//
//  Created by Pasonatech on 2021/05/18.
//

import Foundation
import Vision
import UIKit

class OCRReading{

    func ocrRequest(imageInput: UIImage? = nil)->String?{
        var request = VNRecognizeTextRequest(completionHandler: nil)
        
        var image : UIImage?
        if imageInput == nil {
            image = self.getTestUIImage()!
        } else {
            image = imageInput
        }
        let requestHandler = VNImageRequestHandler(cgImage: image!.cgImage!)
        
        var result:String?
        
        request = VNRecognizeTextRequest{ (request, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            result = self.ocrRecognize(from: request)
        }
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en-US","en-GB"]
        request.usesLanguageCorrection = true
        do {
            try requestHandler.perform([request])
        } catch{
            print("unable to perform ther requests: \(error).")
        }
        return result
    }
    private func getTestUIImage() -> UIImage? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "engImg", withExtension: "png") else { return nil }
        guard let tdata = try? Data(contentsOf: url) else { return nil }
        let tImage = UIImage(data: tdata)   
        
        return tImage
    }
    func ocrRecognize(from request: VNRequest) -> String? {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return nil
        }
        
        let recognizedStrings: [String] = observations.compactMap{ (obersvation) in
            guard let topCandidate = obersvation.topCandidates(1).first else { return nil}
            
            return topCandidate.string.trimmingCharacters(in: .whitespaces)
        }
        print(recognizedStrings)
        return recognizedStrings.joined(separator: "\n")
    }
}
