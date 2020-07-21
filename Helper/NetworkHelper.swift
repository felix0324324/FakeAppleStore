//
//  NetworkingManager.swift
//  MapController
//
//  Created by Lloyd Fung on 30/1/2018.
//  Copyright © 2018年  Property. All rights reserved.
//

import Alamofire
import KakaJSON

//typealias NMReqCompletion<T> = (_ requestID: Int, _ model: T?)->Void
//typealias ResponseComp = (_ requestID: Int, _ jsonDict: [String:Any]?)->Void

// MARK: - Server Domain
struct Domain {
    static var AppleDomain = "https://itunes.apple.com/hk/"
}

// MARK: - API Name
class API: NSObject {
    static var TopFreeAPPDetails = Domain.AppleDomain + "lookup?id="
    static var TopFreeApp = Domain.AppleDomain + "rss/topfreeapplications/limit=100/json"
    static var TopGrossAPP = Domain.AppleDomain + "rss/topgrossingapplications/limit=10/json"
}

class NetworkingManager {
    
    class func requestTopFreeApp(compBlock: @escaping ((ASListModel?) -> Void)) {
        Self.request(url: API.TopFreeApp, method: .get, completion: { requestID, jsonDict  in
            if let aASListModel = jsonDict?.kj.model(type: ASListModel.self) as? ASListModel {
                compBlock(aASListModel)
            } else {
                compBlock(nil)
            }
        })
    }
    
    // <T: ASListModel>
    //<T: Convertible>
    class func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default, completion: @escaping ((Int, [String: Any]?) -> Void)) {
        // let requestID = willRequest()
        AF.request(url, method: method,  parameters: parameters, encoding: encoding)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    var aDict: [String: Any]?
                    if let aJSON = value as? [String: Any] {
                        print("NetworkingManager request - Case 1")
                        aDict = aJSON
                    }
                    completion(0, aDict)
                    print("NetworkingManager request - Case 2")
                case .failure(let error):
                    print("NetworkingManager request - Case 3 Error : \(error)")
                    completion(0, nil)
                }
        }
    }
}


// MARK: - NetworkingManager + Cache
extension NetworkingManager {
    static var suiteName = "NMCache_"
    
    static func setCache(request: DataRequest, data: Data?) {
        guard let data = data else { return }
        let url = request.request!.url!
        let key = "\(NetworkingManager.suiteName)\(url)"
        
        let userDefaults = UserDefaults.init(suiteName: NetworkingManager.suiteName)!
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getCache(request: DataRequest) -> Data? {
        let url = request.request!.url!
        let key = "\(NetworkingManager.suiteName)\(url)"
        
        let userDefaults = UserDefaults.init(suiteName: NetworkingManager.suiteName)!
        return userDefaults.data(forKey: key)
    }
    
    static func clearCache() {
        let userDefaults = UserDefaults.init(suiteName: NetworkingManager.suiteName)!
        let prefix = NetworkingManager.suiteName
        
        for key in userDefaults.dictionaryRepresentation().keys {
            if key.contains(prefix) {
                userDefaults.removeObject(forKey: key)
            }
        }
        userDefaults.synchronize()
    }
}


