//
//  JsonPractice.swift
//  FileDownload
//
//  Created by Pasonatech on 2021/02/12.
//
import Foundation

struct JsonPractice : Codable {
    
    
    struct Results : Codable{
        let ipadScreenshotUrls : [String]
        let appletvScreenshotUrls : [String]
        let artworkUrl60 : String
        let artworkUrl512 : String
        let artworkUrl100 : String
        let artistViewUrl : String
        let screenshotUrls : [String]
        let isGameCenterEnabled : Bool
        let supportedDevices : [String]
        let advisories : [String]
        let features : [String]
        let kind : String
        let trackCensoredName : String
        let languageCodesISO2A : [String]
        let fileSizeBytes : String
        let sellerUrl : String
        let contentAdvisoryRating : String
        let averageUserRatingForCurrentVersion : Int
        let userRatingCountForCurrentVersion : Int
        let averageUserRating : Int
        let trackViewUrl : String
        let trackContentRating : String
        let trackId : Int
        let trackName : String
        let releaseDate : String
        let genreIds : [String]
        let formattedPrice : String
        let primaryGenreName : String
        let isVppDeviceBasedLicensingEnabled : Bool
        let minimumOsVersion : String
        let sellerName :String
        let currentVersionReleaseDate : String
        let releaseNotes : String
        let primaryGenreId : Int
        let currency : String
        let description : String
        let artistId : Int
        let artistName : String
        let genres : [String]
        let price : Int
        let bundleId :String
        let version : String
        let wrapperType : String
        let userRatingCount : Int
    }
    
    let resultCount : Int
    let results : Results
}


