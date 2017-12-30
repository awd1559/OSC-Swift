//
//  Client.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/30.
//  Copyright © 2017年 awd. All rights reserved.
//

import Alamofire

class Client {
    private static let defaultHeaders: HTTPHeaders = [
        "User-Agent": "Mozilla",
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
    ]
    
    private static let tokenHeads: HTTPHeaders = [
        "User-Agent": "",
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
        "AppToken": AppToken
    ]
    
    private static var alamofire: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = defaultHeaders
        return SessionManager(configuration: configuration)
    }()
    
    private static var alamofireWithAppToken: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = tokenHeads
        return SessionManager(configuration: configuration)
    }()
    
    static func networkError(_ error: Error) {
        DispatchQueue.main.async {
            let HUD = Utils.createHUD()
            HUD.mode = .customView
            HUD.detailsLabel.text = error.localizedDescription
            HUD.hide(animated: true, afterDelay: 2)
        }
    }
    static func parseError(_ message: String) {
        DispatchQueue.main.async {
            let HUD = Utils.createHUD()
            HUD.mode = .customView
            HUD.detailsLabel.text = message
            HUD.hide(animated: true, afterDelay: 2)
        }
    }
    static func banners(param: [String: Any], success: @escaping (([OSCBanner])->Void)) {
        let url = OSCAPI_V2_PREFIX + OSCAPI_BANNER + "?catalog=1"
        Alamofire.request(url)
            .responseSwiftyJSON{ response in
                if let error = response.error {
                    networkError(error)
                    return
                }
                
                let code = response.value!["code"].intValue
                if code != 1 {
                    parseError(response.value!["message"].stringValue)
                    return
                }
                
                let items = response.value!["result"]["items"].arrayValue
                var list = [OSCBanner]()
                for json in items {
                    var item = OSCBanner()
                    item.name = json["name"].stringValue
                    item.detail = json["detail"].stringValue
                    item.img = json["img"].stringValue
                    item.href = json["href"].stringValue
                    item.type = InformationType(rawValue: json["type"].intValue)!
                    item.id = json["id"].intValue
                    item.time = json["pubDate"].stringValue
                    list.append(item)
                }
                DispatchQueue.main.async {
                    success(list)
                }
        }
    }
    
    static func sublist(param: [String: Any], success: @escaping (([OSCListItem])->Void)) {
        let url = OSCAPI_V2_PREFIX + OSCAPI_INFORMATION_LIST
        
        alamofireWithAppToken.request(url, parameters: param)
            .responseSwiftyJSON{ response in
                if let error = response.error {
                    print("network error: " + error.localizedDescription)
                    return
                }
                
                let code = response.value!["code"].intValue
                if code != 1 {
                    print("response not expacted")
                    return
                }
                
                let items = response.value!["result"]["items"].arrayValue
                var list = [OSCListItem]()
                for json in items {
//                    var item = OSCListItem()
//                    item.name = json["name"].stringValue
//                    item.detail = json["detail"].stringValue
//                    item.img = json["img"].stringValue
//                    item.href = json["href"].stringValue
//                    item.type = InformationType(rawValue: json["type"].intValue)!
//                    item.id = json["id"].intValue
//                    item.time = json["pubDate"].stringValue
//                    list.append(item)
                }
                DispatchQueue.main.async {
                    success(list)
                }
        }
    }
    
}
