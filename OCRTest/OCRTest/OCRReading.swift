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

    func ocrRequest(imageInput: UIImage? = nil)->(String?,String?){
        var request = VNRecognizeTextRequest(completionHandler: nil)
        
        var image : UIImage?
        if imageInput == nil {
            image = self.getTestUIImage()!
        } else {
            image = imageInput
        }
        let requestHandler = VNImageRequestHandler(cgImage: image!.cgImage!)
        
        var result:String?
        var result2: String?
        
        request = VNRecognizeTextRequest{ (request, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            (result,result2) = self.ocrRecognize(from: request)
        }
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en-US","en-GB"]
        request.usesLanguageCorrection = true
        do {
            try requestHandler.perform([request])
        } catch{
            print("unable to perform ther requests: \(error).")
        }
        return (result,result2)
    }
    
    private func getTestUIImage() -> UIImage? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "engImg", withExtension: "png") else { return nil }
        guard let tdata = try? Data(contentsOf: url) else { return nil }
        let tImage = UIImage(data: tdata)   
        
        return tImage
    }
    
    func ocrRecognize(from request: VNRequest) -> (String?,String?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return (nil,nil)
        }
        
        var recognizedStrings: [String] = observations.compactMap{ (obersvation) in
            guard let topCandidate = obersvation.topCandidates(1).first else { return nil}
            
            return topCandidate.string.trimmingCharacters(in: .whitespaces)
        }
        
        let result = recognizedStrings.joined(separator: "\n")
        print("-------------")
        print(recognizedStrings)
        
//        recognizedStrings = listCheck(recognizedStrings)
//        recognizedStrings = onlyValue(recognizedStrings)
        recognizedStrings = onlyValueByList(recognizedStrings)
        return (recognizedStrings.joined(separator: "\n"),result)
    }
    
    //ISOと言う文字が含まれている値の順番を探す
    func listCheck(_ recognizedStrings:[String]) -> [String] {
        var checkList:[Int] = []
        for i in 0..<recognizedStrings.count {
            if recognizedStrings[i].contains("ISO"){
                checkList.append(i)
            }
        }
        return removeIndex(checkList, recognizedStrings)
    }
    
    //探した順番に該当する値を消す。
    func removeIndex(_ checkList:[Int], _ recognizedStrings:[String]) -> [String]{
        var result = recognizedStrings
        for i in checkList.reversed() {
            result.remove(at: i)
        }
        print("------------------------")
        print(result)
        return result
    }
    
    //Exampleの場合、二番目のものが望む値なのでそれだけ残す。
    func onlyValue(_ list:[String]) -> [String] {
        var result:[String] = []
        for i in 0..<list.count {
            if i%2 == 1 {
                result.append(list[i])
            }
        }
        print("------------------------")
        print(result)
        return result
    }
    
    let titleList = ["Product Name","Flash Point","Viscosity","Sulphur Content","density at","Water Content","ISO"]
    //項目のタイトルを利用して値だけ残す。
    func onlyValueByList(_ list:[String]) -> [String] {
        var result:[String] = []
        for i in list {
            if check(i) {
                result.append(i)
            }
        }
        print("------------------------")
        print(result)
        return result
    }
    
    func check(_ c: String) -> Bool {
        for i in titleList {
            if c.contains(i){
                return false
            }
        }
        return true
    }
}
