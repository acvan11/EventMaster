//
//  CacheManager.swift
//  EventMaster827
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

enum DataResponse {
    case valid(Data)
    case empty
    case error(Error)
}
typealias DataHandler = (DataResponse) -> Void

final class CacheManager {
    
    
    static let shared = CacheManager()
    private init() {}
    
    let cache = NSCache<NSString, NSData>()
    
    
    
    func download(from endpoint: String, completion: @escaping DataHandler) {
        
        //1. check if data is in cache
        if let data = cache.object(forKey: endpoint as NSString) {
            completion(.valid(data as Data))
            return
        }
        
        guard let url = URL(string: endpoint) else {
            completion(.empty)
            return
        }
        
        //2. API Request
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.error(error))
                return
            }
            
            if let data = dat {
                //3. Save Data to Cache
                self.cache.setObject(data as NSData, forKey: endpoint as NSString)
                
                //4. pass data to completion
                DispatchQueue.main.async { //go to main thread to pass completion
                    completion(.valid(data))
                }
            }
            
        }.resume()
    }
    
    
}
