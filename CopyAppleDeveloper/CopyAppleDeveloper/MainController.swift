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
     
     Section은 위에서 정의한 열거형 enum Section이 들어가게 되고,
     Item으로는 위의 OutlineItem이 들어간다.
     
     DiffableDataSource는 개발자가 데이터의 변동을 비교적 쉽게 건드릴 수 있도록 하여, 코드의 복잡함을 줄이고, 런타임 에러를 없애기 위해 등장했다.
     
     */
    var dataSource : UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    
    /*
     첫 화면의 CollectionView를 설정하는 부분
     >> AppleDeveloper에서는 코드로만 구성했으나, StoryBoard를 섞어서 진행해보는 중
     원래 코드
     
     */
    var outlineCollectionView : UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //첫 화면이 네비게이션이기 때문에 해당 타이틀을 설정
        navigationItem.title = "Use Diffable DataSource"
        
        //CollectionView 적용
        configureCollectionView()
        //DataSource 적용
        configureDataSource()
    }
    /*
     lazy는 스위프트에 존재하는 지연저장 프로퍼티로
     보통 저장 프로퍼티는 인스턴스가 생성될 시에 함께 초기화 되어 메모리에 올라가는데
     호출되지도 않았는데 메모리에 올라간다면 메모리의 낭비가 초래된다.
     이때 지연저장 프로퍼티를 사용하면,
     호출되는 순간에 초기화가 되면서 매모리 소모를 줄일 수 있다.
     하지만, 이는 그저 값만 주면 초기화되는 저장 프로퍼티가 아니기 때문에 (로직을 통해 초기화가 됨) 따라서 이를 클로져로 단 한번 실행 되도록 한다.
     그렇기에 마지막에 ()를 반드시 붙여줘야 한다.
     
      Clousure클로저란?
     클로저는 사용자의 코드 안에서 전달되어 사용할 수 있는 로직을 가진 중괄호로 구분된 코드의 블럭이며, 일급 객체의 역할을 할 수 있다.
     전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달 할 수 있으며, 함수의 반환 값이 될수도 있다.
     참조 타입
     함수는 클로저의 한 형태로, 이름이 있는 클로져가 함수이다.
     표현 방식 은
     {(인자들) -> 변환 타입 in
        로직
     }
     in을 기점으로 파라미터, 반환타입 영역과 실제 클로저의 코드를 분리하고 있다.
     
     아래의 함수는 첫 화면에 나타낼 메뉴의 가지수를 정하고 있다.
     */
    private lazy var menuItem: [OutlineItem] = {
        return [
            OutlineItem(a: "Compositional Layout", c: [
                OutlineItem(a: "Advanced Layouts", c: [
                    OutlineItem(a: "Orthogonal Sections", c: [
                        OutlineItem(a: "Orthogonal Sections", b: FirstViewController.self),
                        OutlineItem(a: "Orthogonal Section Behaviors", b: SecondViewController.self)
                    ])
                ]),
                OutlineItem(a: "Conference App", c:[
                    OutlineItem(a: "Video", b: VideoViewController.self)
                ])
            ]),
            OutlineItem(a: "Diffable Data Source", c: [
                OutlineItem(a: "Insertion Sort Visualization", b: InsertionSortViewController.self)
            ]),
            OutlineItem(a: "Outlines", c: [
                OutlineItem(a: "Emoji Explorer", b: EmojiExplorerViewController.self)
            ]),
            OutlineItem(a: "#42081 AppStoreみたいな画面", b:PracticeViewController.self)
        ]
    }()
}

/*
 Extension이란, 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 때 사용하는 기능
 새로운 기능을 추가할 수는 있지만, 기존에 존재하던 기능을 재정의 할 수는 없다.
 상속은 특정 타입을 물려받아 새로운 타입을 정의하고 추가 기능을 정의하는 수직확장이지만,
 익스텐션은 기존의 타입에 기능을 추가하는 수평확장이다.
 
 외부에서 가져온 원본 소스는 수정할 수 없기 때문에 내가 원하는 기능을 추가하고 싶을 때 사용하는 것도 가능하다.
 */
extension MainController {
    
    //collectionView설정
    func configureCollectionView(){
        /*
         generateLayout을 통해 레이아웃을 받고, 뷰의 경게선을 통해 프레임을 구축하여 CollectionView에 적용할 변수를 생성한다.
         위에서 설정된 변수를 reciever의 하위 보기 목록 끝에 보기를 추가한다.
         >> view가 추가가 되는데, 추가된 view는 다른 하위 항목 위에 나타나게 된다 ??
         */
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        
        /*
         상위 뷰가 변경될 때 크기를 조정하는 방법을 결정한다. CollectionView의 크기를 조정하는데
         view의 한계가 변경되면, 해당 view는 각 하위 view의autoresizingMask에 따라 크기를 자동으로 조정하게 된다.
         */
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //collectionView의 뒷 배경 색깔을 지정
        collectionView.backgroundColor = .systemGroupedBackground
        //CollectionView에 정의한 내용들을 입력
        self.outlineCollectionView = collectionView
        //delegate 연결
        collectionView.delegate = self
    }
    
    //DataSource설정
    func configureDataSource(){
        /*
         containerCellRegistration 변수
         UICollectionView.CellResitration<>값이 nil값인지 확인
         >> Collection Cell의 등록 -> 셀을 collection View에 등록하고, 각 셀을 표시하도록 구성한다.
         --> UICollectionViewListCell유형의 셀에 대한 셀 등록을 생성하여, 시스템 기본 스타일을 통해 콘텐츠 구성을 만들고, 내용, 모양을 정의하여 셀에 할당한다.
         nil이 아닐 경우
         
         변수애 해당 값을 넣고, (cell, indexPath, menuItem)를 각 매개타입으로 가지고, 반환 값이 없는 함수를 실행
         */
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> {
            (cell, indexPath, menuItem) in
            //셀의 스타일에 대한 기본 목록 내용 구성을 검색하여 UIContentConfiguration값으로 저장한다.
            var contentConfiguration = cell.defaultContentConfiguration()
            //셀 내용에 텍스트를 추가하여, 메뉴아이템이 들어있는 title값을 적어낸다.
            contentConfiguration.text = menuItem.title
            //텍스트의 포트를 설정한다.
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            //새롭게 정의된 셀의 스타일을 셀에 적용시켜준다.
            cell.contentConfiguration = contentConfiguration
            
            //개요를 공개할 떼에 관한 구성 옵션 설정
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            //개요 공개에 관한 부수적인 옵션 설정 _ 위에서 만든 값을 옵션으로 추가
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            //배경에 있는 구성요소를 깨끗하게 지워버림(투명한 배경을 생성하는 Clear를 사용하여 빈 배경 구성을 만드는 것으로 시작)
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        // 다시금 새로운 변수에 셀 모양을 정의하여 적용한다.
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> {
            (cell, indexPath, menuItem) in
            // Populate the cell with our item description.
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        //위와 똑같은 작업을 하지만, 폰트에는 아무 효과를 주지 않았다. 그리고, 공개 옵션도 설정하지 않았다.
//        print(1)
//        print(dataSource)
        /*
         DiffableDataSource변수에 값을 초기화
         다시금 말하지만,UICollectionViewDiffableDataSource는 데이터를 관리하고, CollectionView의 셀을 제공하는데 사용하는 오브젝트이다.
         CollectionView를 데이터로 채우기 위해 -> 다른 데이터 소스를 ColelctionView에 연결 -> 셀 공급자를 구현하여 CollectionView의 셀을 구성
         -> 데이터의 현재 상태를 생성 -> UI에 데이터를 표시
         outlineCollectionViewㅇ로 부터 데이터 값을 가져옴 ??
         함수 실행 (UICollectionViewCell값을 반환)
         */
        // 여기 들어 오기 전엔 nil값
        dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: outlineCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: OutlineItem) -> UICollectionViewCell? in
            // Return the cell.
            print("v")
            if item.subitems.isEmpty {
                //하위 항목이 없을 경우 cellRegistration을 넣어서 CollectionView에 보낸다.
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                //하위 항목이 읶을 경우 containerCellRegistration로 설정한 것을 보낸다.
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        }
        //처음에 dataSource의 클로저 함수에는 도달하지 못하지만, 초기화가 되었기 때문에 dataSource에 접근이 가능해짐
        //띠라서 맨 마지막 문장이 위에 올라가면, nil값에 의한 오류가 발생하지만, 초기화 이후라면, 오류가 발생하지 않게 된다.
//        print(2)
//        print(dataSource)
        // load our initial data
        // 처음으로 데이터를 정리해서 가져와 준다.(항목별), 처음에는 데이터소스가 nil값이라 여기부터 실행한다고 생각하면 됨
        let snapshot = initialSnapshot()
        //snapshot 값을 데이터 소스에 적용
        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
    }
    
    /*
     Layout을 생성하는 함수인 듯 하다.
     함수의 매개변수는 없고, 반환하는 타입은 UICollectionViewLayout타입을 반환한다. (레이아웃을 반환하는 것)
     */
    func generateLayout() -> UICollectionViewLayout{
        /*
         Layout의 목록 설정 타입을 받아와서 사이드 바 형식으로 나타내는 것 같다.
         종류에는
         .sidebar
         .plain
         .sidebarPlain
         .grouped
         .insetGrouped 가 있는데 목록이 출력되는 것에 있어 영향을 끼친다. (https://useyourloaf.com/blog/creating-lists-with-collection-view/)를 참고하면 좋을 듯하다.
         */
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        /*
         매우 적응적이고, 유연한 시각적 배열로 항목을 결합할 수 있는 레이아웃 객체이다.
         하나이상의 Section으로 구성되는데, 각 section은 표시할 데이터의 최소 단위인 개별 항목의 그룹으로 구성된다.
         그룹은 항목을 수평 행, 수직 열 또는 사용자 정의 배열로 배치할 수 있다.
         */
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        /*
         항목을 결합한 레이아웃을 리턴
         */
        return layout
    }
    
    /*
     데이터의 상태 보낸다고 생각하면 된다.
     */
    func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem>{
        /*
         NSDiffableDataSourceDectionSnapshot은
         특정 시점의 레이아웃 섹션에 있는 데이터의 상태를 나타낸다.
         */
        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
        
        /*
         실행 함수, 리턴값이 존재하지 않는다.
         outlineItem배열을 받아서 처리한다.
         _ 와 to 는 전달 인자이며, 함수 내부에선, menuItems와  parent로 사용한다.
         */
        func addItem(_ menuItems: [OutlineItem], to parent: OutlineItem?){
//            print(String(menuItems.count), "a")
            //snapshot의 append함수에 menuItem와 parent(nil)값을 전달
            snapshot.append(menuItems, to : parent)
            /*
             for문을 시작하는데
             menuitems의 첫번째 menuitem에 하위 항목이 비어있지 않으면 반복문을 실행, 그렇지 않으면 나온다.
             */
            for menuItem in menuItems where !menuItem.subitems.isEmpty {
//                print("b")
                /*
                 들어가서 하위 항목과 menuitem자체를 addItem에 보내는데
                 구조상 하위 항목이 없을 때까지 이 행동을 반복하게 된다.
                */
                addItem(menuItem.subitems, to: menuItem)
            }
            /*
             이렇게 반복문을 빠져나오고 이젠 그 다음 항목의 하위항목을 체크
             없다면 다시 빠져 나오는 방식으로
             처음의 항목을 나타내고, 각 첫번째 항목의 하위항목을 검사하여 가장 밑바닥까지 확인을해서 모든 항목을 꺼내온다.
             */
//            print("v")
        }
        /*
         addItem으로 menuItem 값으로 menuItem(MainController의  menuItem을 호출)을 전달
         parent의 값은  OutlineItem? 옵셔널이기 때문에 nil로 전달
         */
        addItem(menuItem, to: nil)
        //위의 함수를 이용하여 snapshot에는 모든 항목의 상태가 저장된 상태로 리턴을 하는 것
        return snapshot
    }
}

/*
 UICollectionViewDelegate의 상속을 받고 있다.
 Delegate는 컨텐츠의 표현, 사용자와의 상호작용과 관련된 측면을 관리하는 객체이다.
 셀을 강조하거나, 선택하여 표시하는 역할을 하고 있다.
 기능을 확장하여, 셀의 크기, 간격과 같은 레이아웃 설정도 가능하다.
 */
extension MainController: UICollectionViewDelegate{
    
    //Delegate를 상속받았기 때문에 이 함수를 정의해주어야 한다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         guard는 스위프트의 조건문의 표현식 중 하나로, else가 반드시 필요하다.
         guard뒤의 코드의 실행 결과가 true일 경우에 코드가 계속 실행한다.
         guard뒤의 Bool값이 false라면, else를 실행하는데 else 구문의 블록 내부에는 꼭 자신보다 상위의 코드 블록을 종료하는 코드가 들어가게 된다.
         if에 비해 훨씬 간결하고, 읽기 좋게 구성할 수 있다.
         
          menuItem이 nil값이 아니라면 계속 진행 될 것이다.
          Item의 indexPath값을 토대로 identifierType값을 가져온다???
         */
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else {return}
        
        //???
        collectionView.deselectItem(at: indexPath, animated: true)
        
        /*
         Optional이란
         값이 있을 수도 있고, nil일 수도 있는 것을 나타낼때 사용하는데 변수의 뒤에 ?를 붙여준다.
         nil값인 상태를 사용하려 할 때 오류가 날 수 있기 때문에 이를 꼭 확인해서 써야 한다.
         Optional Binding
         if 조건문을 이용하여, optional값이 존재하면 그 값을 변수에 대입시켜준다. 그리고 이하의 if문을 실행한다.
         optional Chaning
         optional binding과정을 ? 키워드로 줄여주는 역할을 한다.
         if let viewController = menuItem.outlineViewController {
            if let navigartionController = navigaionController, navigationController.pushViewController{
                ...
            } else {
                ...
            }
         }
          이런 느낌이려나???
         */
        if let viewController = menuItem.outlineViewControl{
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
        // 여튼 nil이 아닐경우 화면에 출력하는 부분인듯함??s
    }
}
