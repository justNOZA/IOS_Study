//
//  Pretender.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//

import Foundation

class LibraryPresenter {
    
    //잘되고 있는 것인가 슈ㅜ발
    private var librarayService : ListArrayService
    private weak var libView : LibView?
    
    init(_ service : ListArrayService){
        self.librarayService = service
    }
    func attachView(_ view : LibView){
        self.libView = view
    }
    func getList(){
        libView?.startLoading()
        librarayService.downloadData { [weak self] list in
            DispatchQueue.main.async {
                //Dispath를 쓰지 않으면, 멈추지 않는다.
                self?.libView?.finishLoading()
            }
            
            guard !list.isEmpty else {
                DispatchQueue.main.async {
                    self?.libView?.setEmptyList()
                }
                return
            }
            let dataList = list.map{
                LibViewData(title: "\($0.item?.title as! String)", author: "\($0.item?.author as! String)", publisherName: "\($0.item?.publisherName as! String)", samllImageUrl: "\($0.item?.smallImageUrl as! String)", largeImageUrl: "\($0.item?.largeImageUrl as! String)", itemCaption: "\($0.item?.itemCaption as! String)")
            }
            print(type(of: list[0].item?.title as! String))
            DispatchQueue.main.async {
//                print(dataList)
                self?.libView?.setList(dataList)
            }
        }
    }
}
