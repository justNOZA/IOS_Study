import Foundation

class Support{
    
    
    var practices = [[String:Any]]()

    struct StoreList: Hashable {
        var title: String
        var category: String
        var url : String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    struct ListCollection: Hashable {
        var title: String
        var list: [StoreList]
        var description : String
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
extension Support {
    func generateCollections(){
        let path = Bundle.main.path(forResource: "ImageUrl", ofType: "json")
        if let data = try? String(contentsOfFile: path!).data(using: .utf8){
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            as! [[String: Any]]
            practices = json
            
            var collection : ListCollection = ListCollection(title: "", list: [], description: "")
            
            for A in practices {
                collection.title = (A["title"] as? String)!
                collection.description = (A["description"] as? String)!
                guard let lists = A["list"] as? [[String:Any]] else {
                    return
                }
                var listItem : [StoreList] = []
                for B in lists {
                    var item : StoreList = StoreList(title: "", category: "", url: "")
                    item.title = (B["title"] as? String)!
                    item.category = (B["category"] as? String)!
                    item.url = (B["url"] as? String)!
                    listItem.append(item)
                }
                collection.list = listItem
                _collections.append(collection)
            }
        }
    }
}
