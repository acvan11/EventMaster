//
//  Service.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

final class MasterService {
    static let shared = MasterService()
    private init(){}
    
    func getAttractions (completion: @escaping ([Attraction] ) -> Void){
        guard let url = MasterAPI().getAttractionUrl else {
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { (dat ,_, err) in
            if let error = err {
                print(error.localizedDescription)
                completion([])
                return
            }
            if let data = dat {
                do {
                    let jsonResponse = try JSONDecoder().decode(JsonResponse.self, from: data)
                    let attractions = jsonResponse._embedded.attractions
                    completion(attractions)
                
                    
                } catch {
                    print("Could Not Decode!:" + error.localizedDescription)
                    completion([])
                    return
            
                }
            }
        }.resume()
    }
    
    
}
