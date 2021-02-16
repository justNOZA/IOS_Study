//
//  TestCell.swift
//  AppStoreCopy
//
//  Created by Pasonatech on 2021/02/16.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    @IBOutlet weak var testLabel: UILabel!
}
