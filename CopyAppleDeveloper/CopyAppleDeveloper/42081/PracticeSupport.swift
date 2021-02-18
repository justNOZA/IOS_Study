import Foundation

class PracticeSupport {
    
    
    
    //Cell에 들어갈 구조 설정
    struct StoreList: Hashable {
        let title: String
        let category: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    struct ListCollection: Hashable {
        let title: String
        let list: [StoreList]
        let description : String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    var collections: [ListCollection] {
        return _collections
    }

    init() {
        generateCollections()
    }
    
    fileprivate var _collections = [ListCollection]()
}

extension PracticeSupport {
    func generateCollections() {
        _collections = [
            ListCollection(title: "Game",
                            list: [StoreList(title: "Game1", category: "first"),
                                     StoreList(title: "Game2", category: "first"),
                                     StoreList(title: "Game3", category: "first"),
                                     StoreList(title: "Game4", category: "first"),
                                     StoreList(title: "Game5", category: "first"),
                                     StoreList(title: "Game6", category: "first")],
                            description: "Recents"),

            ListCollection(title: "Shop",
                           list: [StoreList(title: "shop1", category: "secondzxczxczxczxczxczxczczxczxczx"),
                                    StoreList(title: "shop2", category: "secondzxczxczxcxczxczxczxczxc"),
                                    StoreList(title: "shop3", category: "secondzxczxczxc"),
                                    StoreList(title: "shop4", category: "second"),
                                    StoreList(title: "shop5", category: "second"),
                                    StoreList(title: "shop6", category: "second"),
                                    StoreList(title: "shop7", category: "second"),
                                    StoreList(title: "shop8", category: "second"),
                                    StoreList(title: "shop9", category: "second"),
                                    StoreList(title: "shop10", category: "second"),
                                    StoreList(title: "shop11", category: "second"),
                                    StoreList(title: "shop12", category: "second")
                           ],
                           description: "List"),

            ListCollection(title: "Entertain",
                           list: [StoreList(title: "entertain1", category: "third"),
                                     StoreList(title: "entertain2", category: "third"),
                                     StoreList(title: "entertain3", category: "third"),
                                     StoreList(title: "entertain4", category: "third"),
                                     StoreList(title: "entertain5", category: "third"),
                                     StoreList(title: "entertain6", category: "third"),
                                     StoreList(title: "entertain7", category: "third"),
                                     StoreList(title: "entertain8", category: "third"),
                                     StoreList(title: "entertain9", category: "third")
                           ],
                           description: "List"),

            ListCollection(title: "SNS",
                           list: [StoreList(title: "sns1", category: "fourth"),
                                     StoreList(title: "sns2", category: "fourth"),
                                     StoreList(title: "sns3", category: "fourth"),
                                     StoreList(title: "sns4", category: "fourth"),
                                     StoreList(title: "sns5", category: "fourth"),
                                     StoreList(title: "sns6", category: "fourth"),
                                     StoreList(title: "sns7", category: "fourth"),
                                     StoreList(title: "sns8", category: "fourth"),
                                     StoreList(title: "sns9", category: "fourth"),
                                     StoreList(title: "sns10", category: "fourth"),
                                     StoreList(title: "sns11", category: "fourth"),
                                     StoreList(title: "sns12", category: "fourth"),
                                     StoreList(title: "sns13", category: "fourth"),
                                     StoreList(title: "sns14", category: "fourth"),
                                     StoreList(title: "sns15", category: "fourth"),
                           ],
                           description: "List"),

            ListCollection(title: "Delivery",
                           list: [StoreList(title: "delivery1", category: "fifth"),
                                     StoreList(title: "delivery2", category: "fifth"),
                                     StoreList(title: "delivery3", category: "fifth"),
                                     StoreList(title: "delivery4", category: "fifth"),
                                     StoreList(title: "delivery5", category: "fifth"),
                                     StoreList(title: "delivery6", category: "fifth"),
                                     StoreList(title: "delivery7", category: "fifth"),
                                     StoreList(title: "delivery8", category: "fifth"),
                                     StoreList(title: "delivery9", category: "fifth")
                           ],
                           description: "List")
        ]
    }
}
