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

        let block = tesseract.recognizedBlocks(from: image, for: .block)
        print("---------------------------------------ocrRB BLOCK------------------------")
        do {
            let (value, value2) = try block.get()
            print("-----------string")
            print("\(value)")
            print("-----------Recognizedblock")
            print("\(value2)")
        } catch {
            print("Error retrieving the value: \(error)")
        }
        
//        //space.. 
//        let word = tesseract.recognizedBlocks(from: image, for: .word)
//        print("---------------------------------------ocrRB WORD------------------------")
//        do {
//            let (value, value2) = try word.get()
//            print("-----------string")
//            print("\(value)")
//            print("-----------Recognizedblock")
//            print("\(value2)")
//        } catch {
//            print("Error retrieving the value: \(error)")
//        }
        
//        //line
//        let textline = tesseract.recognizedBlocks(from: image, for: .textline)
//        print("---------------------------------------ocrRB TEXTLINE------------------------")
//        do {
//            let (value, value2) = try textline.get()
//            print("-----------string")
//            print("\(value)")
//            print("-----------Recognizedblock")
//            print("\(value2)")
//        } catch {
//            print("Error retrieving the value: \(error)")
//        }
        
        //
        let paragraph = tesseract.recognizedBlocks(from: image, for: .paragraph)
        print("---------------------------------------ocrRB PARAGRAPH------------------------")
        do {
            let (value, value2) = try paragraph.get()
            print("-----------string")
            print("\(value)")
            print("-----------Recognizedblock")
            print("\(value2)")
        } catch {
            print("Error retrieving the value: \(error)")
        }
        
//        // character
//        let symbol = tesseract.recognizedBlocks(from: image, for: .symbol)
//        print("---------------------------------------ocrRB SYMBOL------------------------")
//        do {
//            let (value, value2) = try symbol.get()
//            print("-----------string")
//            print("\(value)")
//            print("-----------Recognizedblock")
//            print("\(value2)")
//        } catch {
//            print("Error retrieving the value: \(error)")
//        }
        return resultText
    }
//    func ocrReading() -> String?{
//        var resultText = ""
//        let image = self.getTestUIImage()
//        let result = tesseract.performOCR(on: image!)
//        do {
//            let value = try result.get()
//            print("The value is \(value).")
//            resultText = value
//        } catch {
//            print("Error retrieving the value: \(error)")
//        }
//        return resultText
//    }
//    private func getTestUIImage() -> UIImage? {
//        guard let url = Bundle(for: type(of: self)).url(forResource: "engImg", withExtension: "png") else { return nil }
//        guard let tdata = try? Data(contentsOf: url) else { return nil }
//        let tImage = UIImage(data: tdata)
//        
//        return tImage
//    }
}
