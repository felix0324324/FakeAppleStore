////
////  ASGrossAppModel.swift
////
////  Created by Alvis on 21/7/2020.
////  Copyright © 2020 Alvis. All rights reserved.
////
//
//import UIKit
//import Foundation
//import KakaJSON
//
//
//// MARK: - ASListModel
//struct ASGrossAppModel: Convertible {
//    var feed: Feed?
//}
//
//// MARK: - Feed
//struct Feed: Convertible {
//    var author: Author?
//    var entry: [Entry]?
//    var updated, rights, title, icon: Icon?
//    var link: [FeedLink]?
//    var id: Icon?
//}
//
//// MARK: - Author
//struct Author: Convertible {
//    var name, uri: Icon?
//}
//
//// MARK: - Icon
//struct Icon: Convertible {
//    var label: String?
//}
//
//// MARK: - Entry
//struct Entry: Convertible {
//    var imName: Icon?
//    var imImage: [IMImage]?
//    var summary: Icon?
//    var imPrice: IMPrice?
//    var imContentType: IMContentType?
//    var rights, title: Icon?
//    var link: [EntryLink]?
//    var id: ID?
//    var imArtist: IMArtist?
//    var category: Category?
//    var imReleaseDate: IMReleaseDate?
//
//    enum CodingKeys: String, CodingKey {
//        case imName
//        case imImage
//        case summary
//        case imPrice
//        case imContentType
//        case rights, title, link, id
//        case imArtist
//        case category
//        case imReleaseDate
//    }
//}
//
//// MARK: - Category
//struct Category: Convertible {
//    var attributes: CategoryAttributes?
//}
//
//// MARK: - CategoryAttributes
//struct CategoryAttributes: Convertible {
//    var imid, term: String?
//    var scheme: String?
//    var label: String?
//
//    enum CodingKeys: String, CodingKey {
//        case imid
//        case term, scheme, label
//    }
//}
//
//// MARK: - ID
//struct ID: Convertible {
//    var label: String?
//    var attributes: IDAttributes?
//}
//
//// MARK: - IDAttributes
//struct IDAttributes: Convertible {
//    var imid, imBundleId: String?
//
//    enum CodingKeys: String, CodingKey {
//        case imid
//        case imBundleId
//    }
//}
//
//// MARK: - IMArtist
//struct IMArtist: Convertible {
//    var label: String?
//    var attributes: IMArtistAttributes?
//}
//
//// MARK: - IMArtistAttributes
//struct IMArtistAttributes: Convertible {
//    var href: String?
//}
//
//// MARK: - IMContentType
//struct IMContentType: Convertible {
//    var attributes: IMContentTypeAttributes?
//}
//
//// MARK: - IMContentTypeAttributes
//struct IMContentTypeAttributes: Convertible {
//    var term, label: String?
//}
//
//// MARK: - IMImage
//struct IMImage: Convertible {
//    var label: String?
//    var attributes: IMImageAttributes?
//}
//
//// MARK: - IMImageAttributes
//struct IMImageAttributes: Convertible {
//    var height: String?
//}
//
//// MARK: - IMPrice
//struct IMPrice: Convertible {
//    var label: String?
//    var attributes: IMPriceAttributes?
//}
//
//// MARK: - IMPriceAttributes
//struct IMPriceAttributes: Convertible {
//    var amount, currency: String?
//}
//
//// MARK: - IMReleaseDate
//struct IMReleaseDate: Convertible {
//    var label: String?
//    var attributes: Icon?
//}
//
//// MARK: - EntryLink
//struct EntryLink: Convertible {
//    var attributes: PurpleAttributes?
//    var imDuration: Icon?
//
//    enum CodingKeys: String, CodingKey {
//        case attributes
//        case imDuration
//    }
//}
//
//// MARK: - PurpleAttributes
//struct PurpleAttributes: Convertible {
//    var rel, type: String?
//    var href: String?
//    var title, imAssetType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case rel, type, href, title
//        case imAssetType
//    }
//}
//
//// MARK: - FeedLink
//struct FeedLink: Convertible {
//    var attributes: FluffyAttributes?
//}
//
//// MARK: - FluffyAttributes
//struct FluffyAttributes: Convertible {
//    var rel, type: String?
//    var href: String?
//}
