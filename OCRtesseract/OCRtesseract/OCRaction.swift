//
//  OCRaction.swift
//  tesseractOCR
//
//  Created by Pasonatech on 2021/05/19.
//

import UIKit
import SwiftyTesseract

class OCRaction {
    let tesseract = Tesseract(language: RecognitionLanguage.english)
    
    func ocrActing(_ image: UIImage) -> String{
        var resultText = "over"
        print("---------------------------------------normal------------------------")
        let result = tesseract.performOCR(on: image)
        do {
            let value = try result.get()
//            print("\(value)")
            resultText = value
        } catch {
            print("Error retrieving the value: \(error)")
        }
        let block = tesseract.recognizedBlocks(from: image, for: .block)
    
//        print("---------------------------------------ocrRB------------------------")
//        do {
//            let (value, value2) = try block.get()
//            print("-----------string")
//            print("\(value)")
//            print("-----------Recognizedblock")
//            print("\(value2)")
//        } catch {
//            print("Error retrieving the value: \(error)")
//        }
//
        return resultText
    }
    func ocrReading() -> String?{
        var resultText = ""
        let image = self.getTestUIImage()
        let result = tesseract.performOCR(on: image!)
        do {
            let value = try result.get()
            print("The value is \(value).")
            resultText = value
        } catch {
            print("Error retrieving the value: \(error)")
        }
        return resultText
    }
    private func getTestUIImage() -> UIImage? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "engImg", withExtension: "png") else { return nil }
        guard let tdata = try? Data(contentsOf: url) else { return nil }
        let tImage = UIImage(data: tdata)
        
        return tImage
    }
}
