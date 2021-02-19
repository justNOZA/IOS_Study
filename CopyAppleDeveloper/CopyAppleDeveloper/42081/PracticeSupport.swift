import Foundation

class PracticeSupport{
    
    
    var practices = [[String:Any]]()

//    //Cell에 들어갈 구조 설정
//    struct StoreList: Hashable {
//        let title: String
//        let category: String
//        let identifier = UUID()
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(identifier)
//        }
//    }
    struct StoreList2: Hashable {
        var title: String
        var category: String
        var url : String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    struct ListCollection2: Hashable {
        var title: String
        var list: [StoreList2]
        var description : String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
//    struct ListCollection: Hashable {
//        var title: String
//        let list: [StoreList]
//        let description : String
//        let identifier = UUID()
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(identifier)
//        }
//    }
/*
    var collections: [ListCollection] {
        return _collections
    }
 */
    var collections2: [ListCollection2] {
        return _collections2
    }
    
    init() {
//        generateCollections()
        generateCollections2()
    }
    
//    fileprivate var _collections = [ListCollection]()
    fileprivate var _collections2 = [ListCollection2]()
}
extension PracticeSupport {
    func generateCollections2(){
        let path = Bundle.main.path(forResource: "ImageUrl", ofType: "json")
        if let data = try? String(contentsOfFile: path!).data(using: .utf8){
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            as! [[String: Any]]
            practices = json
            
            var collection : ListCollection2 = ListCollection2(title: "", list: [], description: "")
            
            for A in practices {
                collection.title = (A["title"] as? String)!
                collection.description = (A["description"] as? String)!
                guard let lists = A["list"] as? [[String:Any]] else {
                    return
                }
                var listItem : [StoreList2] = []
                for B in lists {
                    var item : StoreList2 = StoreList2(title: "", category: "", url: "")
                    item.title = (B["title"] as? String)!
                    item.category = (B["category"] as? String)!
                    item.url = (B["url"] as? String)!
                    listItem.append(item)
                }
                collection.list = listItem
                _collections2.append(collection)
            }
        }
    }
}
//extension PracticeSupport {
//    func generateCollections() {
//        _collections = [
//            ListCollection(title: "Game",
//                            list: [StoreList(title: "Game1", category: "first"),
//                                     StoreList(title: "Game2", category: "first"),
//                                     StoreList(title: "Game3", category: "first"),
//                                     StoreList(title: "Game4", category: "first")],
//                            description: "Recents"),
//
//            ListCollection(title: "Shop",
//                           list: [StoreList(title: "shop1", category: "secondzxczxczxczxczxczxczczxczxczx"),
//                                    StoreList(title: "shop2", category: "secondzxczxczxcxczxczxczxczxc"),
//                                    StoreList(title: "shop3", category: "secondzxczxczxc"),
//                                    StoreList(title: "shop4", category: "second"),
//                                    StoreList(title: "shop5", category: "second"),
//                                    StoreList(title: "shop6", category: "second")
//                           ],
//                           description: "List"),
//
//            ListCollection(title: "Entertain",
//                           list: [StoreList(title: "entertain1", category: "third"),
//                                     StoreList(title: "entertain2", category: "third"),
//                                     StoreList(title: "entertain3", category: "third"),
//                                     StoreList(title: "entertain4", category: "third"),
//                                     StoreList(title: "entertain5", category: "third"),
//                                     StoreList(title: "entertain6", category: "third"),
//                                     StoreList(title: "entertain7", category: "third")
//                           ],
//                           description: "List"),
//
//            ListCollection(title: "SNS",
//                           list: [StoreList(title: "sns1", category: "fourth"),
//                                     StoreList(title: "sns2", category: "fourth"),
//                                     StoreList(title: "sns3", category: "fourth"),
//                                     StoreList(title: "sns4", category: "fourth"),
//                                     StoreList(title: "sns5", category: "fourth"),
//                                     StoreList(title: "sns6", category: "fourth"),
//                                     StoreList(title: "sns7", category: "fourth"),
//                                     StoreList(title: "sns8", category: "fourth")
//                           ],
//                           description: "List"),
//
//            ListCollection(title: "Delivery",
//                           list: [StoreList(title: "delivery1", category: "fifth"),
//                                     StoreList(title: "delivery2", category: "fifth"),
//                                     StoreList(title: "delivery3", category: "fifth"),
//                                     StoreList(title: "delivery4", category: "fifth"),
//                                     StoreList(title: "delivery5", category: "fifth")
//                           ],
//                           description: "List")
//        ]
////    print(_collections)
//    }
//}
