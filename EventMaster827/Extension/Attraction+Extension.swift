//
//  Attraction+Extension.swift
//  EventMaster827
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension Attraction {
    
    var toDictionary: [String:String] {
        return ["name":self.name, "id": self.id, "url": self.url, "image": self.image ?? "none", "genre": self.classifications.first!.genre.name]
    }
    
    private var image: String? {
        
        return self.images.first(where: {$0.ratio == "16_9" && $0.url.contains("RETINA_LANDSCAPE")})?.url
    }
    
    func getImage(completion: @escaping (UIImage) -> Void) {
        
        guard let imageEndpoint = self.image else {
            completion(#imageLiteral(resourceName: "hhh"))
            return
        }
        
        CacheManager.shared.download(from: imageEndpoint) { response in
            switch response {
            case .empty:
                completion(#imageLiteral(resourceName: "hhh"))
            case .error( _):
                completion(#imageLiteral(resourceName: "hhh"))
            case .valid(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(#imageLiteral(resourceName: "hhh"))
                }
                
            }
        }
    }
}

extension Attraction: Hashable, Equatable {
    
    static func == (lhs: Attraction, rhs: Attraction) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}
