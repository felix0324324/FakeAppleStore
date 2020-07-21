//
//  ASListDetailModel.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import UIKit
import Foundation
import KakaJSON


// MARK: - ASListModel
struct ASListDetailModel: Convertible {
    var resultCount: Int?
    var results: [Result]?
}

// MARK: - Result
struct Result: Convertible {
    var isGameCenterEnabled: Bool?
    var screenshotUrls, ipadScreenshotUrls: [String]?
    // let appletvScreenshotUrls: [JSONAny]?
    var artworkUrl512, artworkUrl60, artworkUrl100: String?
    var artistViewUrl: String?
    var supportedDevices, advisories: [String]?
    var kind: String?
    var features: [String]?
    var trackCensoredName: String?
    var languageCodesISO2A: [String]?
    var fileSizeBytes: String?
    var sellerUrl: String?
    var averageUserRatingForCurrentVersion: Double?
    var userRatingCountForCurrentVersion: Int?
    var trackViewUrl: String?
    var trackContentRating, contentAdvisoryRating: String?
    var averageUserRating: Double?
    var trackId: Int?
    var trackName, releaseDate: String?
    var genreIds: [String]?
    var formattedPrice, primaryGenreName: String?
    var isVppDeviceBasedLicensingEnabled: Bool?
    var primaryGenreId: Int?
    var minimumOsVersion, currentVersionReleaseDate, releaseNotes, sellerName: String?
    var currency, version, wrapperType: String?
    var artistId: Int?
    var artistName: String?
    var genres: [String]?
    var price: Int?
    var resultDescription, bundleId: String?
    var userRatingCount: Int?

//    enum CodingKeys: String, CodingKey {
//        case isGameCenterEnabled, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl512, artworkUrl60, artworkUrl100, artistViewUrl, supportedDevices, advisories, kind, features, trackCensoredName, languageCodesISO2A, fileSizeBytes, sellerUrl, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, trackViewUrl, trackContentRating, contentAdvisoryRating, averageUserRating, trackId, trackName, releaseDate, genreIds, formattedPrice, primaryGenreName, isVppDeviceBasedLicensingEnabled, primaryGenreId, minimumOsVersion, currentVersionReleaseDate, releaseNotes, sellerName, currency, version, wrapperType, artistId, artistName, genres, price
//        case resultDescription
//        case bundleId, userRatingCount
//    }
}

