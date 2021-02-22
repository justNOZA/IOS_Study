//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Pasonatech on 2021/02/22.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }

    private var operations: Dictionary<String,Operation> = [
//        "π" : Double.pi,
//        "e" : M_E
//        "√" : sqrt
//        "cos" : cos
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({-$0}),
        "×" : Operation.binaryOperation({ $0 * $1 }), //클로저...
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
/*
        switch /*mathematicalSymbol*/symbol {
            case "π":
//                    display!.text = "\(Double.pi)"
//                displayValue = Double.pi
                accumulator = Double.pi
            case "√":
//                    let operand = Double(display.text!)!
//                    display.text = String(sqrt(operand))
//                displayValue = sqrt(displayValue)
                if let operand = accumulator{
                    accumulator = sqrt(operand)
                }
            default :
                break
        }
*/
        if let operation = operations[symbol] {
//            accumulator = constant
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    //구조체나 열거형은 값 타입이므로 메서드 앞에 mutating키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 변경하는 것임을 명시해야 한다.
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
