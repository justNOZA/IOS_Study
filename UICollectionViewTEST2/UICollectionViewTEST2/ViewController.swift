//
//  ViewController.swift
//  UICollectionViewTEST2
//
//  Created by Pasonatech on 2021/02/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var num : [Int] = []
//    var scale : CGFloat!
//    var targetSize : CGFloat!
    @IBOutlet weak var testCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        
        for i in 1...20 {
            num.append(i)
        }
        //메인 스크린의 넓이
//        scale = UIScreen.main.bounds.size.width
//        targetSize = scale / 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num.count
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath)
        return cell
    }
//
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = testCollectionView.frame.width
        let itemsPerRow: CGFloat = 4
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let cellwidth = (size - widthPadding) / itemsPerRow
        let cellHeight = cellwidth
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

