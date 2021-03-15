//
//  FormUINumber.swift
//  ttc_bdn
//
//  Created by pasonatech on 2020/12/10.
//

import Foundation

let a = "aaa"
let b = ""
let c = "123"
let d = "asd213"
let e = "%2dsaa"
let f = "0.2"

print(a.isNumber)
print(b.isNumber)
print(c.isNumber)
print(d.isNumber)
print(e.isNumber)
print(f.isNumber)

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
