//
//  ASListModel.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import UIKit
import Foundation
import KakaJSON


// MARK: - ASListModel
struct ASListModel: Convertible {
    var feed: Feed?
}

// MARK: - Feed
struct Feed: Convertible {
    var author: Author?
    var entry: [Entry]?
    var updated, rights, title, icon: Icon?
    var link: [FeedLink]?
    var id: Icon?
}

// MARK: - Author
struct Author: Convertible {
    var name, uri: Icon?
}

// MARK: - Icon
struct Icon: Convertible {
    var label: String?
}

// MARK: - Entry
struct Entry: Convertible {
    var imName: Icon?
    var imImage: [IMImage]?
    var summary: Icon?
    var imPrice: IMPrice?
    var imContentType: IMContentType?
    var rights, title: Icon?
    var id: ID?
    var imArtist: IMArtist?
    var category: Category?
    var imReleaseDate: IMReleaseDate?
    var asListDetailModel: ASListDetailModel?

    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        // 根据属性名来返回对应的key
        switch property.name {
            case "imName": return "im:name"
            case "imImage": return "im:image"
            case "imPrice": return "im:price"
            case "imContentType": return "im:contentType"
            case "imArtist": return "im:artist"
            case "imReleaseDate": return "im:releaseDate"
            default: return property.name
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case imName = "im:name"
//        case imImage = "im:image"
//        case summary
//        case imPrice = "im:price"
//        case imContentType = "im:contentType"
//        case rights, title, link, id
//        case imArtist = "im:artist"
//        case category
//        case imReleaseDate = "im:releaseDate"
//    }
}

// MARK: - Category
struct Category: Convertible {
    var attributes: CategoryAttributes?
}

// MARK: - CategoryAttributes
struct CategoryAttributes: Convertible {
    var imid, term: String?
    var scheme: String?
    var label: String?
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        // 根据属性名来返回对应的key
        switch property.name {
            case "imid": return "im:id"
            default: return property.name
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case imid = "im:id"
//        case term, scheme, label
//    }
}

// MARK: - ID
struct ID: Convertible {
    var label: String?
    var attributes: IDAttributes?
}

// MARK: - IDAttributes
struct IDAttributes: Convertible {
    var imid, imBundleId: String?
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        // 根据属性名来返回对应的key
        switch property.name {
            case "imid": return "im:id"
            case "imBundleId": return "im:bundleId"
            default: return property.name
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case imid = "im:id"
//        case imBundleId = "im:bundleId"
//    }
}

// MARK: - IMArtist
struct IMArtist: Convertible {
    var label: String?
    var attributes: IMArtistAttributes?
}

// MARK: - IMArtistAttributes
struct IMArtistAttributes: Convertible {
    var href: String?
}

// MARK: - IMContentType
struct IMContentType: Convertible {
    var attributes: IMContentTypeAttributes?
}

// MARK: - IMContentTypeAttributes
struct IMContentTypeAttributes: Convertible {
    var term, label: String?
}

// MARK: - IMImage
struct IMImage: Convertible {
    var label: String?
    var attributes: IMImageAttributes?
}

// MARK: - IMImageAttributes
struct IMImageAttributes: Convertible {
    var height: String?
}

// MARK: - IMPrice
struct IMPrice: Convertible {
    var label: String?
    var attributes: IMPriceAttributes?
}

// MARK: - IMPriceAttributes
struct IMPriceAttributes: Convertible {
    var amount, currency: String?
}

// MARK: - IMReleaseDate
struct IMReleaseDate: Convertible {
    var label: String?
    var attributes: Icon?
}

//enum LinkUnion: Convertible {
//    case feedLink(FeedLink)
//    case purpleLinkArray([PurpleLink])
//
//    init(from decoder: Decoder) throws {
//        var container = try decoder.singleValueContainer()
//        if let x = try? container.decode([PurpleLink].self) {
//            self = .purpleLinkArray(x)
//            return
//        }
//        if let x = try? container.decode(FeedLink.self) {
//            self = .feedLink(x)
//            return
//        }
//        throw DecodingError.typeMismatch(LinkUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LinkUnion"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .feedLink(let x):
//            try container.encode(x)
//        case .purpleLinkArray(let x):
//            try container.encode(x)
//        }
//    }
//}

// MARK: - PurpleLink
struct PurpleLink: Convertible {
    var attributes: PurpleAttributes?
    var imDuration: Icon?

    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Convertible {
    var rel, type: String?
    var href: String?
    var title, imAssetType: String?

    enum CodingKeys: String, CodingKey {
        case rel, type, href, title
        case imAssetType = "im:assetType"
    }
}

// MARK: - FeedLink
struct FeedLink: Convertible {
    var attributes: FluffyAttributes?
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Convertible {
    var rel, type: String?
    var href: String?
}
