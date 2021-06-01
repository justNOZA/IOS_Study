//
//  OCRReading.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/01.
//

import Vision
import UIKit

class OCRReading {
    
    func ocrRequest(image: UIImage)->String?{
        var request = VNRecognizeTextRequest(completionHandler: nil)
        
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!)
        
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
        do {
            try requestHandler.perform([request])
        } catch{
            print("unable to perform ther requests: \(error).")
        }
        return result
    }
    
    private func ocrRecognize(from request: VNRequest) -> String? {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return nil
        }
        
        let recognizedStrings: [String] = observations.compactMap{ (obersvation) in
            guard let topCandidate = obersvation.topCandidates(1).first else { return nil}
            
            return topCandidate.string.trimmingCharacters(in: .whitespaces)
        }
        return recognizedStrings.joined(separator: "\n")
    }
}
