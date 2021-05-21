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
        let resultText = "over"
        let block = tesseract.recognizedBlocks(from: image, for: .block)
        do {
            let value = try block.get()
            print("The value is \(value).")
        } catch {
            print("Error retrieving the value: \(error)")
        }
        let result = tesseract.performOCR(on: image)
        do {
            let value = try result.get()
            print("The value is \(value).")
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
