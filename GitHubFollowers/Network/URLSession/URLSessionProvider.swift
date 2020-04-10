//
//  URLSessionProvider.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import SystemConfiguration

let NETWORK = URLSessionProvider.shared

final class URLSessionProvider: URLSessionProviderProtocol {

    static var shared = URLSessionProvider()
    
    private var session: URLSessionProtocol
    private let REQUEST_TIME = 80.00
    private var online = false
    private let imageCache = NSCache<NSString, UIImage>()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func urlCahcePolicy(_ isCache: Bool) -> URLRequest.CachePolicy {
        online = Reachability.isOnline()
        return isCache ? (online ? .reloadIgnoringCacheData : .returnCacheDataDontLoad) : .reloadIgnoringCacheData
    }
    
    func request<T>(type: T.Type?, service: ServiceProtocol, completion: @escaping (Response<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service, cachePolicy: urlCahcePolicy(true), timeoutInterval: REQUEST_TIME)
        
        var task: URLSessionDataTask? = nil
        task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            
            #if DEBUG
            self?.info(task!, request.httpBody, data, response, error)
            #endif
            
            self?.handleResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task?.resume()
    }
    
    func handleResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (Response<T>) -> ()) {
        guard error == nil else {
            let apiError = AppError(type: online ? .server : .network)
            return completion(.onFailure(apiError))
        }
        
        guard let response = response else {
            let apiError = AppError(type: .noData)
            return completion(.onFailure(apiError))
        }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data, let result = try? Decoder().decode(T.self, from: data) else {
                let apiError = AppError(type: .parsing)
                completion(.onFailure(apiError))
                return
            }
            completion(.onSuccess(result))
            completion(.onCompleted)
        default:
            guard let data = data, let fail = try? JSONDecoder().decode(Fail.self, from: data) else {
                let apiError = AppError(type: .server)
                completion(.onFailure(apiError))
                return
            }
            let apiError = AppError(message: fail.message, type: .known)
            completion(.onFailure(apiError))
        }
    }
    
    func info(_ task: URLSessionDataTask, _ body: Any?, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
        let url: String = task.originalRequest?.url?.absoluteString ?? ""
        let headers: [String: String] = task.originalRequest?.allHTTPHeaderFields ?? [:]
        let statusCode: Int = (task.response as? HTTPURLResponse)?.statusCode ?? 0
        let response: String = String(data: data ?? Data(), encoding: .utf8) ?? ""
        Console.logAPI(url, headers, body as Any, statusCode, response, error)
    }
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> ()) {
        let cacheKey = NSString(string: url)
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
        } else {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                    error == nil,
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode),
                    let image = UIImage(data: data) else {
                        completion(nil)
                        return
                }
                
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(image)
            }
            task.resume()
        }
    }
}
