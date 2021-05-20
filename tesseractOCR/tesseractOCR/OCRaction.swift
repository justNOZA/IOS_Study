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
    func ocrReading() -> String?{
        var resultText = ""
        let image = self.getTestUIImage()
        swiftyTesseract.performOCR(on: image!, completionHandler: {RecognitionLanguage in
            guard let text = RecognitionLanguage else {return}
            print(text)
            resultText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        })
        return resultText
    }
    private func getTestUIImage() -> UIImage? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "engImg", withExtension: "png") else { return nil }
        guard let tdata = try? Data(contentsOf: url) else { return nil }
        let tImage = UIImage(data: tdata)
        
        return tImage
    }
}
