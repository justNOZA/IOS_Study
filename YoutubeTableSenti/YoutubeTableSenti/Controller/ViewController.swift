//
//  ViewController.swift
//  YoutubeTableSenti
//
//  Created by Pasonatech on 2021/02/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let gUrl = GetUrl()
    var news : [[String:Any]]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //how many?
        //셀의 개수..
        if let data = news {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //what?
        //위에서 정한 횟수만큼 반복해서 진행한다.
        /*
         2가지 방법
         1 : 임의의 셀을 만듦 ->
         2 : 스토리보드 + ID를 이용해서
         */
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellTypeDefault")
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "tableCell1", for: indexPath) as! TableViewCell1
        // as? 타입을 안전하게 추론하는 as?
        // as! 타입을 강제로 변환
//        cell.textLabel?.text = "\(indexPath.row)"
//        cell.cell1Label.text = "\(indexPath)"
        if let data = news{
           
            if let v = data[indexPath.row] as? [String:Any] {
                if let title = v["title"] as? String{
                    cell.cell1Label.text = title
                }
             }
        }
        return cell
    }
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NewsAPI"
        self.navigationItem.backButtonTitle = "Back"
        // Do any additional setup after loading the view.
        tableViewMain.delegate = self
        //tableViewMain 테이블 뷰의 경우 ViewController내부에서 찾아서 받으라는 명령어
        tableViewMain.dataSource = self
        news = gUrl.getNews()
    }

    //1.
    //table View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        indexPath.row
        let storyboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let newsDetail = storyboard.instantiateViewController(identifier: "newsDetail") as! NewsDetailController
        if let data = news {
            if let v = data[indexPath.row] as? [String:Any] {
                if let url = v["urlToImage"] as? String{
                    newsDetail.imageUrl = url
                }
                if let desc = v["description"] as? String{
                    newsDetail.descriptionNews = desc
                }
             }
        }

        showDetailViewController(newsDetail, sender: nil)

    }

    //2.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "naviSegue" == id {
            if let controller = segue.destination as? NewsDetailController {
                if let data = news {
                    if let indexpath = tableViewMain.indexPathForSelectedRow {
                        if let v = data[indexpath.row] as? [String:Any] {
                            if let url = v["urlToImage"] as? String{
                                controller.imageUrl = url
                            }
                            if let desc = v["description"] as? String{
                                controller.descriptionNews = desc
                            }
                        }
                        controller.navigationItem.title = "\(indexpath.row)"
                    }
                }
            }
        }
     }
        //자동
    

    /*
     HTTP 통신 : 네트워크 프로토콜 / URLSession
     JSON 데이터 형태 => {"A(key)":"A(value)"} : 현 시대에 가장 빠른 데이터 송신 형태
                    {
                        [
                            "ㄱ",
                            "ㄴ",
                            "ㄷ",
                            "{"ㅌ:ㅋ"}"
                        ]
                     }
     네트워크 통신을 할 때 BackGround에서 작동하기 때문에 진행 속도가 다르다.
     */
}

