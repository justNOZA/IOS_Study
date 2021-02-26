//
//  ViewController.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {

//    enum Section {
//        case main
//    }
    
    lazy var active = ActivityIndicator(self)
    
    var libraryPresenter = LibraryPresenter(ListArrayService())
    var libViewData = [LibViewData]()
    
//    var dataSource : UITableViewDiffableDataSource<Section, LibViewData>! = nil
//    var currentSnapshot : NSDiffableDataSourceSnapshot<Section, LibViewData>! = nil
    
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ActivityIndicator적용
        listTable.dataSource = self
        listTable.delegate = self
        self.navigationItem.title = "Rakuten Lib"
        self.navigationItem.backButtonTitle = "Back"
        
        self.view.addSubview(active.indicator)
        libraryPresenter.attachView(self)
        libraryPresenter.getList()
    }
}

extension ViewController : LibView {
    func startLoading() {
        active.indicator.startAnimating()
    }
    func finishLoading() {
        active.indicator.stopAnimating()
    }
    func setEmptyList() {
        listTable.isHidden = true
    }
    func setList(_ datas: [LibViewData]) {
        libViewData = datas
        
        listTable.isHidden = false
        listTable.reloadData()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return libViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableCell", for: indexPath) as! ListTableCell
 
        cell.listLabel.text = libViewData[indexPath.row].title
        if let data = try? Data(contentsOf: URL(string: libViewData[indexPath.row].samllImageUrl)!){
            cell.listImg.image = UIImage(data: data)
        }
            //
        return cell
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "libDetail" == id {
            if let control = segue.destination as? LibDetailView{
                if let index = listTable.indexPathForSelectedRow{
                    control.author = libViewData[index.row].author
                    control.bookTitle = libViewData[index.row].title
                    control.caption = libViewData[index.row].itemCaption
                    control.img = libViewData[index.row].largeImageUrl
                    control.publisher = libViewData[index.row].publisherName
                }
            }
        }
    }
}
