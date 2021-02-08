//
//  ViewController.swift
//  navigationPractice
//
//  Created by Pasonatech on 2021/02/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
         처음에 다 삭제
         navi controller생성
         root삭제
         view Controller 생성
         root view 어쩌고 저쩌고 연결
         navi의 is initial controller 설정
         
         view controller를 첫번째 view에 연결
         
         두번째 view 생성
         클래스 파일 하나 생성
         두번째 view의 컨트롤러 연결 및 Id 설정 !!
         
         다시 처음 view로 넘어와서 클릭 이벤트 생성
         */
    }
    
    
    @IBAction func MoveBtn(_ sender: Any) {
        // 스토리 보드 찾기
        if let moveC = self.storyboard?.instantiateViewController(withIdentifier: "Detail"){
            //두번째 view의 ID로 찾아서 연결
            self.navigationController?.pushViewController(moveC, animated: true)
            
            //옵셔널 바인딩?!!
            
            //이동 ! 두번째 뷰컨 찾아서 넣는 것?! push
        }
    }
    
}

