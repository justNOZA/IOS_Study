//
//  DarkMode.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/08.
//

import Foundation
import UIKit

class DarkMode: UIView {
    private let xibName = "DarkMode"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
