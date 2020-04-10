//
//  URLRequest+Extensions.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import SystemConfiguration

extension URLRequest {
    
    init(service: ServiceProtocol, cachePolicy: CachePolicy, timeoutInterval: TimeInterval) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        httpMethod = service.method.rawValue
        
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        addValue(APIHeader.applicationJson.rawValue, forHTTPHeaderField: APIHeader.contentType.rawValue)
        addValue(APIHeader.applicationJson.rawValue, forHTTPHeaderField: APIHeader.accept.rawValue)
        addValue(APIHeader.ios.rawValue, forHTTPHeaderField: APIHeader.deviceOS.rawValue)
        
        if let uuid = UIDevice.current.identifierForVendor {
            addValue(uuid.uuidString, forHTTPHeaderField: APIHeader.deviceId.rawValue)
        }
        
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            addValue(appVersion, forHTTPHeaderField: APIHeader.applicationVersion.rawValue)
        }
        
        if let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as? String {
            addValue(appBuild, forHTTPHeaderField: APIHeader.buildNumber.rawValue)
        }
        
        guard let body = service.body else { return }
        guard let dic = (body as! Codable).asDictionary() else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: dic)
    }
}
