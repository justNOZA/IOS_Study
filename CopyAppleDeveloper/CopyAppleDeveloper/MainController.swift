//
//  MainController.swift
//  CopyAppleDeveloper
//
//  Created by Pasonatech on 2021/02/16.
//

import UIKit

class MainController: UIViewController {
    
    /*
     스위프트의 열거형은 enum으로 선언할 수 있다.
     아래의 경우는 Section이라는 이름을 갖는 열거형에 main이라는 항목이 들어가 있는 것이다.
     각 항목은 그 자체가 고유의 값이 된다.
     열거의 형의 각 항목은 그 자체로도 하나의 값이 되지만, 항목의 원시값(Row Value)도 가질 수 있다.
     
     일부 값만 원시 값을 할당 할 수 있으며,
     문자형의 원시 값을 할당하면, 그 자체가 원시값을 가지게 되고(항목 값과 원시 값이 동일해짐),
     정수 타입이라면, 0부터 1씩 늘어난 값이 할당된다. 자동적으로
     
     원시 값을 통해 열거형 변수 혹은 상수를 생성할 수 도 있다.
     
     아래의 열거형을 통해 색션의 값을 정의해주고 있다.
     */
    enum Section {
        case main
        /*
         case Tester = "PARK" >> Tester라는 항목의 원시 값으로 PARK를 할당한 표현
         원시 값을 사용하고 싶을 때는
         ex) Section.Tester => Tester
             Section.Tester.rawValue => PARK
         열거형 변수 생성
         let Tester = Section(rawValue: "Tester") => Tester 변수의 값은 Tester가 된다.
         하지만
         let Tester = Section(rawValue: "Smart") => 이와 같이 없는 원식 값을 적용하면 nil값이 반환된다.
         */
    }
    
    /*
     OutlineItem Class의 경우 Hashable프로토콜을 준수해야 한다.
     Hashable은 Swift 표준 라이브러리에 정의되어 있는 프로토콜이며, 스의프트의 기본 타입 String, Int, Bool, 열거형(enum) 등은 모두 Hashable프로토콜을 준수해야 한다.
     Hahable은 정수 Hash 값을 제공하고, Dictionary의 키가 될 수 있는 타입이다. (즉, 그 자체로 유일하게 표현이 가능한 방법을 제공해야 한다.)
     
     아래의 OutlineItem class의 경우 각 변수에 대응하는 값을 넣어주면, 자동으로 hashValue를 만들어 준다.??(확실히 이해하지는 못함)
     
     아래의 클래스를 이용하여 아이템을 정의하고 있다.
     */
    class OutlineItem : Hashable{
        //클래스 변수, 타입 설정
        let title : String
        let subitems : [OutlineItem]
        let outlineViewControl : UIViewController.Type?
        
        //이름 부터 인식하는 변수이다. UUID는 범용 고유 식별자로 중복될 가능성이 없는 값을 준다.
        private let identifier = UUID()
        
        //생성자
        init(a: String,
             b: UIViewController.Type? = nil,
             c: [OutlineItem] = []){
            self.title = a
            self.subitems = c
            self.outlineViewControl = b
            //변수 초기화
        }
        
        //hashable하게 변환
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
            /*
             hasher란 구조체로, 해당 인스턴스의 구성요소를 결합할 때 사용한다.
             comnbine은 제너릭 인스턴스 메소드로 hasher구조체에서 value를 추가하는 메소드이다.
             hasher에 주어진 값을 추가형 그 필수적인 부분을 hasher상태로 혼합하는 것 ??
             */
        }
        static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    /*
     제너릭 타입으로 hashable을 준수하는 두 타입을 가진다.
     (앞)SectionIdentifierType은 각각의 섹션에 들어갈 데이터를 정의한다.
     (뒤)ItemIdentifierType은 섹션 속 아이템들에 들어갈 데이터를 정의한다.
     이 객체에 데이터를 집어 넣고 적용하면, 내부적으로 데이터를 관리해주게 된다.
     */
    var dataSource : UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    @IBOutlet weak var outlineCollectionView: UICollectionView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
