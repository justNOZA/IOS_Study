//
//  ViewController.swift
//  SampleWebView
//
//  Created by Pasonatech on 2021/02/12.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var WebViewMain: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1. url string
        //2. url > request
        //3. request > load
        
        let urlString = "https://www.google.com"
        if let url = URL(string: urlString){
            //unwrapping, 옵셔널 바인딩
            let urlReq = URLRequest(url: url)
            WebViewMain.load(urlReq)
        }
        var abc = "1"
        var abc1 : String? = nil
        
        var aaa = abc1! //값이 무조건 있을 경우 느낌표로 전환한 것만으로 언랩핑이 가능하다. nil값일 때 강제로 언랩핑할 경우 오류 발생! 주의
        if let bbb = abc1 {}
        let abc2 = "2"
        //let의 경우에는 상수이기 때문에 옵셔널을 쓰는 것이 애초에 불필요한 과정이다.
        
        //null pointer exception - java의 경우
        
    }

    
}

