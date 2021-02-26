//
//  ListArray.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/25.
//
struct RakutenLibrary : Codable {
    let items : [Items]?
    let pageCount : Int?
    let hits : Int?
    let last : Int?
    let count : Int?
    let page : Int?
    let carrier : Int?
    let genreInformation : [String]?
    let first : Int?

    enum CodingKeys: String, CodingKey {

        case items = "Items"
        case pageCount = "pageCount"
        case hits = "hits"
        case last = "last"
        case count = "count"
        case page = "page"
        case carrier = "carrier"
        case genreInformation = "GenreInformation"
        case first = "first"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        hits = try values.decodeIfPresent(Int.self, forKey: .hits)
        last = try values.decodeIfPresent(Int.self, forKey: .last)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        carrier = try values.decodeIfPresent(Int.self, forKey: .carrier)
        genreInformation = try values.decodeIfPresent([String].self, forKey: .genreInformation)
        first = try values.decodeIfPresent(Int.self, forKey: .first)
    }

}

struct Items : Codable {
    let item : Item?

    enum CodingKeys: String, CodingKey {

        case item = "Item"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item = try values.decodeIfPresent(Item.self, forKey: .item)
    }

}

struct Item : Codable {
    let hardware : String?
    let limitedFlag : Int?
    let author : String?
    let title : String?
    let listPrice : Int?
    let itemCaption : String?
    let publisherName : String?
    let isbn : String?
    let largeImageUrl : String?
    let jan : String?
    let mediumImageUrl : String?
    let availability : String?
    let os : String?
    let postageFlag : Int?
    let salesDate : String?
    let smallImageUrl : String?
    let label : String?
    let discountPrice : Int?
    let itemPrice : Int?
    let booksGenreId : String?
    let affiliateUrl : String?
    let reviewCount : Int?
    let reviewAverage : String?
    let artistName : String?
    let discountRate : Int?
    let chirayomiUrl : String?
    let itemUrl : String?

    enum CodingKeys: String, CodingKey {

        case hardware = "hardware"
        case limitedFlag = "limitedFlag"
        case author = "author"
        case title = "title"
        case listPrice = "listPrice"
        case itemCaption = "itemCaption"
        case publisherName = "publisherName"
        case isbn = "isbn"
        case largeImageUrl = "largeImageUrl"
        case jan = "jan"
        case mediumImageUrl = "mediumImageUrl"
        case availability = "availability"
        case os = "os"
        case postageFlag = "postageFlag"
        case salesDate = "salesDate"
        case smallImageUrl = "smallImageUrl"
        case label = "label"
        case discountPrice = "discountPrice"
        case itemPrice = "itemPrice"
        case booksGenreId = "booksGenreId"
        case affiliateUrl = "affiliateUrl"
        case reviewCount = "reviewCount"
        case reviewAverage = "reviewAverage"
        case artistName = "artistName"
        case discountRate = "discountRate"
        case chirayomiUrl = "chirayomiUrl"
        case itemUrl = "itemUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hardware = try values.decodeIfPresent(String.self, forKey: .hardware)
        limitedFlag = try values.decodeIfPresent(Int.self, forKey: .limitedFlag)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        listPrice = try values.decodeIfPresent(Int.self, forKey: .listPrice)
        itemCaption = try values.decodeIfPresent(String.self, forKey: .itemCaption)
        publisherName = try values.decodeIfPresent(String.self, forKey: .publisherName)
        isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
        largeImageUrl = try values.decodeIfPresent(String.self, forKey: .largeImageUrl)
        jan = try values.decodeIfPresent(String.self, forKey: .jan)
        mediumImageUrl = try values.decodeIfPresent(String.self, forKey: .mediumImageUrl)
        availability = try values.decodeIfPresent(String.self, forKey: .availability)
        os = try values.decodeIfPresent(String.self, forKey: .os)
        postageFlag = try values.decodeIfPresent(Int.self, forKey: .postageFlag)
        salesDate = try values.decodeIfPresent(String.self, forKey: .salesDate)
        smallImageUrl = try values.decodeIfPresent(String.self, forKey: .smallImageUrl)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        discountPrice = try values.decodeIfPresent(Int.self, forKey: .discountPrice)
        itemPrice = try values.decodeIfPresent(Int.self, forKey: .itemPrice)
        booksGenreId = try values.decodeIfPresent(String.self, forKey: .booksGenreId)
        affiliateUrl = try values.decodeIfPresent(String.self, forKey: .affiliateUrl)
        reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
        reviewAverage = try values.decodeIfPresent(String.self, forKey: .reviewAverage)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        discountRate = try values.decodeIfPresent(Int.self, forKey: .discountRate)
        chirayomiUrl = try values.decodeIfPresent(String.self, forKey: .chirayomiUrl)
        itemUrl = try values.decodeIfPresent(String.self, forKey: .itemUrl)
    }

}
