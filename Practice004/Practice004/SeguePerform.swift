//
//  SeguePerform.swift
//  Practice004
//
//  Created by Pasonatech on 2021/02/09.
//

import UIKit
class SeguePerform: UIStoryboardSegue{
    
    override func perform() {
        /*
        
        let srcUV = self.source
        //.superview?.insertSubview(destUVC.view, aboveSubview: srcUV.view)
        let destUVC = self.destination
        //.frame.origin.x = srcUV.view.frame.size.width
        UIView.transition(from: srcUV.view,
                          to: destUVC.view,
                          duration: 0.5,
                          options: .transitionCurlDown) //좀 더 알아볼 필요가 있음
        */
        self.source.view.superview?.insertSubview(self.destination.view, aboveSubview: self.source.view)
        self.destination.view.frame.origin.x = self.source.view.frame.size.width
        
        UIView.animate(withDuration: 0.25, animations: {
            self.destination.view.frame.origin.x = 0
        }){(finished) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}
