//
//  PracticeViewController.swift
//  CopyAppleDeveloper
//
//  Created by Pasonatech on 2021/02/17.
//

import UIKit

class AppViewController: UIViewController {
    
    
    //셀에 들어갈 구조 생성
    let appController = Support()
    //CollectionView 선언
    var collectionView: UICollectionView! = nil

    var dataSource: UICollectionViewDiffableDataSource
        <Support.ListCollection, Support.StoreList>! = nil
    //snapshot의 선언
    var currentSnapshot: NSDiffableDataSourceSnapshot
        <Support.ListCollection, Support.StoreList>! = nil
    
    static let titleElementKind = "title-element-kind"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "#42081 AppStore Copy"
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshots()
    }
}

extension AppViewController {
    //여기가 두번째
    // 매개변수 없이 컬랙션 뷰의 레이아웃만을 생성해서 전달
    func createLayout() -> UICollectionViewLayout {
        print("2")
        //sectionProvider라는 변수는 숫자와 래아아웃 환경을받아서 레이아웃 섹션을 생성하는 함수이다.
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            print("3")
            //section변수를 선언하여 작업을 시행해준다.
            let section: NSCollectionLayoutSection
            
            //Section을 구분하여 다른 레이아웃 효과를 준다.
//            if self.practiceController.collections[sectionIndex].description == "Recents" {
            if self.appController.collections[sectionIndex].description == "Recents" {
                /*
                 itemSize를 최대치로 설정
                 CollectionView에서 Item의 너비와 높이 설정
                 */
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                /*
                 CollectionView에서 레이아웃의 가장 기본 구성요소
                 CollectionView에서 각 개별 콘텐츠의 크기, 공간 및 배열 방법에 대한 설계로, 아이템은 화면에 단일된 보기르 나타낸다.
                 일반적으로 Item은 셀이지만, 머리글, 바닥글 및 기타 장식과 같은 보조일 수 있다.
                 각 항목은 너비 치수와 높이 치수를 기준으로 자체 크기를 지정한다,
                 */
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // if we have the space, adapt and go 2-up + peeking 3rd item
                //그룹간의 거리 조절하는 듯 ?
                /*
                 CGFloat은 관련 프레임워크의 부동 소수점 스칼라 값에 대한 기본 유형
                 삼항 연산자를 통해, 너비가 500 이상일 경우, 0.425를 그보다 작을 경우 0.85를 적용한다는 것이다.
                 */
                let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                    0.425 : 0.85)
                
                //CollectionView에서 Item의 너비와 높이에 대한 설정이다.
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                       heightDimension: .fractionalHeight(0.3))
                /*
                 CollectionView의 항목이 서로 간에 배치되는 방식을 결정한다. 수평행, 수직열 또는 사용자 정의 배열로 배치할 수 았다.
                 그룹은 서로 간 항목을 랜더링 하는 방법에 대한 규칙을 결정하지만, 그 자체로는 콘텐츠를 랜더링하지 않는다.
                 각 그룹은 너비, 높이를 기준으로 자체 크기를 지정한다. 그룹은 시스템 글꼴 크기 변화에 대응하여, 런타임에 변경될 수 있는 예상 값 또는
                 절대값으로 컨테이너에 상대적인 크기를 표시할 수 있다.
                 */
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                /*
                 그룹 집합을 고유한 시각적 그룹으로 결합하는 컨테이너이다.
                 한 CollectionView Layout애 섹션이 하나 이상 있다. 섹션은 레이아웃을 개별 조각으로 구분하는 방법을 제공한다.
                 각 섹션은 컬렉션 보기의 다른 섹션과 레이아웃이 동일하거나 다를 수 있다.
                 */
                section = NSCollectionLayoutSection(group: group)
                
                //스크롤 기능 설정
                section.orthogonalScrollingBehavior = .groupPagingCentered
                //그룹 간의 공백
                section.interGroupSpacing = 20
                // 각 섹션의 컨텐츠 내 공백 설정
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                //섹션 타이틀 크기 설정
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))

                //타이틀의 디자인 설정
                let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: titleSize,
                    elementKind: AppViewController.titleElementKind,
                    alignment: .top)

                //섹션에 위에서 설정한 타이틀을 추가
                section.boundarySupplementaryItems = [titleSupplementary]
                
//            } else if self.practiceController.collections[sectionIndex].description == "List"{
            } else if self.appController.collections[sectionIndex].description == "List"{
                let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                
                let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
                trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                
                let trailingItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))

                let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.85)
                let containerGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                      heightDimension: .fractionalHeight(0.3)),
                    subitems: [leadingItem, trailingItem, trailingItem2])
                
                section = NSCollectionLayoutSection(group: containerGroup)
                //스크롤 기능 설정
                section.orthogonalScrollingBehavior = .groupPaging
                //그룹 간의 공백
                section.interGroupSpacing = 20
                // 각 섹션의 컨텐츠 내 공백 설정
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                //섹션 타이틀 크기 설정
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))

                //타이틀의 디자인 설정
                let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: titleSize,
                    elementKind: AppViewController.titleElementKind,
                    alignment: .top)

                //섹션에 위에서 설정한 타이틀을 추가
                section.boundarySupplementaryItems = [titleSupplementary]
            } else {
                fatalError("Unknown section!")
            }
//            print("4")
            //위에서 설정한 섹션을 리턴
            return section
        }
        
        /*
         Layout의 스크롤 방향, 횡단 간격 및 머리글 혹은 바닥글을 정의하는 개체
         > Layout의 구성을 사용하여 컬랙션 뷰 레이아웃의 기본 스크롤 방향을 수정하고, 레이아웃의 각 섹션 사이에 간격을 더하고,
           전체 레이아웃에 머리글 혹은 바닥글을 추가할 수 있다.
         */
        let config = UICollectionViewCompositionalLayoutConfiguration()
        //각 섹션간의 간격을 20px추가
        config.interSectionSpacing = 20
        
        /*
         매우 적응적이고, 유연한 시각적 배열로 항목을 결합할 수 있는 레이아웃 오브젝트이다.
         컬랙션 뷰의 한 유형으로, 컴포넌트, 유연성 및 빠른 속도로 설계되어, 각 소형 구성요소를 전체 레이아웃으로 결합하거나, 컴포넌트 함으로써
         컨텐츠에 대한 모든 종류의 시각적 배열을 구축할 수 있다.
         */
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        
        return layout
   }
}

extension AppViewController {
    //여기가 첫번째
    func configureHierarchy() {
        print("1")
        //CollectionCView를 호출하여 해당 레이아웃으로 CollectionView를 설정(컬렉션 뷰의 섹션 설정을 입력함)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        // 뷰의 자동 크기 조정 마스크를 자동 레이아웃 제약 조건으로 변환활지 여부를 결정
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //뷰의 배경 색깔을 지정
        collectionView.backgroundColor = .systemBackground
        //설정한 컬렉션 뷰를 하위뷰로 추가한다.
        view.addSubview(collectionView)
        
        //컬렉션 뷰의 제약조건 활성화
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
    }
    
    func createFirstCellRegistration() -> UICollectionView.CellRegistration<CellControlv1, Support.StoreList>{
        return UICollectionView.CellRegistration<CellControlv1, Support.StoreList> { (cell, indexPath, storeList) in
            // Populate the cell with our item description.
            //타이틀과 카테고리를 받아와서 적용시킨다.
            print("4")
            cell.titleLabel.text = storeList.title
            cell.categoryLabel.text = storeList.category

            let url = URL(string: storeList.url)
            do{
                let data = try Data(contentsOf: url!)
                let urlImage = UIImage(data: data)
                cell.imageView.image = urlImage
                
            }catch{
                print("Error!! SHIT")
            }
            
        }
    }
    
    func createSecondCellRegistration()-> UICollectionView.CellRegistration<CellControlv2, Support.StoreList>{
        return UICollectionView.CellRegistration<CellControlv2, Support.StoreList> { (cell, indexPath, storeList) in
            // Populate the cell with our item description.
            //타이틀과 카테고리를 받아와서 적용시킨다.
            print("5")
            cell.titleLabel.text = storeList.title
            cell.categoryLabel.text = storeList.category

            let url = URL(string: storeList.url)
            do{
                let data = try Data(contentsOf: url!)
                cell.imageView.image = UIImage(data: data)
            }catch{
                print("Error!! SHIT")
            }
        }
    }
    
    func configureDataSource() {
        print("3")
        /*
         CollectionView의 셀에 대한 등록
         */
        let firstCellRegistration = createFirstCellRegistration()
        let SecondCellRegistration = createSecondCellRegistration()
        
        
        //UICollectionViewDiffableDatasource를 인스턴스화 히고 Section과 항목 유형을 매개 변수화 한다. _ 작업하려는 CollectionView에 대한 포인터를 전달
        dataSource = UICollectionViewDiffableDataSource
        <Support.ListCollection, Support.StoreList>(collectionView: collectionView) {
            //DiffabelDataSource가 행당 포인터를 통해 CollectionView의 DataSource로 연결
            (collectionView: UICollectionView, indexPath: IndexPath, storeList: Support.StoreList) -> UICollectionViewCell? in
            // Return the cell.

//            let section = self.practiceController.collections[indexPath.section]
            let section = self.appController.collections[indexPath.section]
            switch section.description {
            case "Recents":
                return collectionView.dequeueConfiguredReusableCell(using: firstCellRegistration, for: indexPath, item: storeList)
            case "List":
                return collectionView.dequeueConfiguredReusableCell(using: SecondCellRegistration, for: indexPath, item: storeList)
            default:
                fatalError("Can't Represent")
            }
        }

    }
    
    
    func applyInitialSnapshots() {
        print("6")
         
        //Cell에 보여주고 싶은 것으로 채운다.
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: AppViewController.titleElementKind) {
            (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description.
                let listCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = listCategory.title
            }
        }

        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    
        currentSnapshot = NSDiffableDataSourceSnapshot<Support.ListCollection, Support.StoreList>()
        appController.collections.forEach {
            //클로저에 전달된 첫번째 매개 변수
            let collection = $0
            //표시할 섹션의 주입
            currentSnapshot.appendSections([collection])
            //다음으로 옵데이트에 표시할 항목의 식벼ㅛㄹ자를 추가, 식별자의 배열을 전달
            currentSnapshot.appendItems(collection.list)
        }
        //Diffable DataSource를 호출하여 해당 snapshot을 적용하여 차이점을 애니메이션 없이 요청
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

