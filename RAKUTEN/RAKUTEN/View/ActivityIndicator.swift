//
//  ActivityIndicator.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//

import UIKit

class ActivityIndicator {
    let indicator = UIActivityIndicatorView()
    
    init(_ task : UIViewController){
        indicator.frame = CGRect(x:0, y:0, width: 50, height: 50)
        indicator.color = .systemPink
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = task.view.center
    }
}
