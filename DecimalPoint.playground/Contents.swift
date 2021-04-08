import UIKit

let formatter = NumberFormatter()
formatter.minimumFractionDigits = 0
formatter.maximumFractionDigits = 3

formatter.string(from: 1.000000)!
formatter.string(from: 1.234556)!

formatter.maximumFractionDigits = -2

formatter.string(from: 1.34423453453)!

extension NSString {
    var isNumber: Bool { //only integer
        return length > 0 && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted).location == NSNotFound
    }
    
    func isNum() -> Bool { // all num
        let str: String = self as String
        return Int(str) != nil || Double(str) != nil
    }
}

extension String {
    var isNumber: Bool { //integer
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
