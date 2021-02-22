//
//  ViewController.swift
//  Calculator
//
//  Created by Pasonatech on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    //info.plist 파일은 폴더아래에 묶었을 경우 빌드 세팅에서 패키지의 파일위치를 수정해 주어야 한다.

    @IBOutlet weak var display: UILabel!
    /*
     IOS프로그램이 실행될 때 약간의 나노시간이 필요하기 때문에 그 상황에 대비해 옵셔널값으로 하는 것이다. UI값은 대분분,,?
     기본적으로 nil로 초기화 된다.
     여기서 먼저 unwrap하면 다음 코드들이 좀더 보기 편해진다. 그래서 여기서 !를 쓰는 것
    */
    //스위프트의 모든 프로퍼티는 초기화가 되어야 한다. 그렇지 않으면 오류가 발생함
    //프로퍼티는 클래스, 구조체, 열거형과 관련한 값이다. (속성)
    /*
     var a = "test"
     var test.b = "test"
     a는 변수, b는 프로퍼티
     */
    var userIsInTheMiddleOfTyping = false
    var pointCheck = false
    
    //UIButton으로 해주는 것이 좋다.
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
//        print("\(digit) was called ")
        if digit == "."{
            if pointCheck {
                return
            }else{
                pointCheck = true
            }
        }
        if userIsInTheMiddleOfTyping{
            //현재 Display의 값을 가져옴
            let textCurrentlyInDisplay = display.text!
            //숫자를 계속 추가하는 문장
            display.text = textCurrentlyInDisplay + digit
        } else{
            //처음 클릭을 하게 되면, userIsInThe... 의 값이 falsed이기 때문에 여기부터 시작
            //0값 대신 digit의 값을 넣게 된다.
            display.text = digit
            //그리고 true로 변환하여 다음부터는 연결되어 값이 출력되도록 진행
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    private var brain: CalculatorBrain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            pointCheck = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
}

