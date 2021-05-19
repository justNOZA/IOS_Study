//
//  OCRaction.swift
//  tesseractOCR
//
//  Created by Pasonatech on 2021/05/19.
//

import Foundation
import SwiftyTesseract

class OCRaction {
    let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.english)
    
    func ocrActing(_ image: UIImage) -> String{
        var resultText = ""
        swiftyTesseract.performOCR(on: image, completionHandler: {RecognitionLanguage in
            guard let text = RecognitionLanguage else {return}
            print(text)
            resultText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        })
        return resultText
    }
}
