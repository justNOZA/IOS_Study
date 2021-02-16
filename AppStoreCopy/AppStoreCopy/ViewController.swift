//
//  ViewController.swift
//  AppStoreCopy
//
//  Created by Pasonatech on 2021/02/16.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    enum Section{
        case main
    }
    @IBOutlet weak var testCollectionView: UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testCollectionView.collectionViewLayout = customList()
        configureHierarchy()
        configureDataSource()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    //item -> cell에 들어가는 가장 작은 객체, cell, 머리글, 바닥글
    //group -> item을 묶은 하나의 그룹
    //section -> group이 묶인 큰 구성체
    //layout -> section을 포함한 전체 틀
    
    //fractional... 비율 / 0.5는 전체 너비 혹은 높이의 절반
    //absolute 고정값
    //estimated 고정값이지만, 우선 제약이 있을 경우 변동함
    private func customList() -> UICollectionViewLayout{
        //아이템의 크기값을 설정, 전체사이즈
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        // > height를 높이면, cell의 높이가 커지고, width를 조절하면, 길이가 영향
        // >> 0.5일 경우 44의 절반인 22가 적용 한개의 셀에
        // 아이템의 레이아웃을 적용
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //그룹의 사이즈를 설정 = 위로부터 44px떨어뜨림, 너비는 전체
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        // > height를 높이면, cell의 높이가 커지고, width를 조절하면, 길이가 영향
        //그룹 레이아웃을 적용, 하위 아이템 배열을 적용하여 표현
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //섹션을 설정
        let section = NSCollectionLayoutSection(group: group)
        //설정된 값을 레이아웃으로 적용하고 베포
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: testCollectionView){
            (collectionView: UICollectionView, indexPath:IndexPath, identifier: Int)-> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as? TestCell else {
                fatalError("cannot create new cell")
            }
//            cell.label.text = "\(identifier)"
            print(cell.testLabel)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    private func configureHierarchy(){
        testCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        testCollectionView.backgroundColor = .systemBlue
        testCollectionView.register(TestCell.self, forCellWithReuseIdentifier: "testCell")
        testCollectionView.delegate = self
    }
    
}

