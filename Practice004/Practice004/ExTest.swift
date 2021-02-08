//
//  ExTest.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/08.
//

import UIKit

extension UILabel {
    @IBInspectable
    public var localizedKey: String? {
        get { fatalError("only set this value") }
        set {
            if let newValue = newValue {
                text = newValue.localized()
            }
        }
    }
}
extension UIButton {
    @IBInspectable
    public var localizedKey: String? {
        get { fatalError("only set this value") }
        set {
            if let newValue = newValue {
                setTitle(newValue.localized(), for: UIControl.State.normal)
            }
        }
    }
}
extension String {
    func localized() -> String? {
        return NSLocalizedString(self, comment: "")
    }
}
