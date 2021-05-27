//
//  OCRReading.swift
//  OCRTest
//
//  Created by Pasonatech on 2021/05/18.
//

import Foundation
import Vision
import UIKit
import TesseractOCR

class OCRReading{

    func ocrRequest(imageInput: UIImage)->String?{
        var request = VNRecognizeTextRequest(completionHandler: nil)
        
        var image : UIImage?
        image = imageInput
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
//        request.usesLanguageCorrection = true () //言語修正を適用する？
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
    
    func tesseractOCR(image: UIImage?, dg : G8TesseractDelegate) -> String?{
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = dg
            tesseract.image = image!
            tesseract.recognize()
            
            return tesseract.recognizedText
        }
        return "can't read photo"
    }

}
