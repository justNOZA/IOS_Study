//
//  LibView.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/25.
//

import Foundation

protocol  LibView : class{
    func startLoading()
    func finishLoading()
    func setEmptyList()
    func setList(_ datas: [LibViewData])
}
