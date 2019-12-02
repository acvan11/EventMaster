//
//  Attraction.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Firebase

struct JsonResponse: Decodable {
    let _embedded: Embedded
}

struct Embedded: Decodable {
    let attractions: [Attraction]
}

struct Attraction: Decodable {
    let name: String
    let id: String
    let url: String
    let images: [Image]
    let classifications: [Classification]
    
    init?(from snap: DataSnapshot) {
        guard let values = snap.value as? [String:String],
            let name = values["name"],
            let id = values["id"],
            let url = values["url"],
            let image = values["image"],
            let genreName = values["genre"] else { return nil }
        
        let genre = Genre(name: genreName)
        
        self.name = name
        self.id = id
        self.url = url
        self.images = [Image(ratio: "16_9", url: image)]
        self.classifications = [Classification(genre: genre)]
    }
    
}

struct Image: Decodable {
    let ratio: String
    let url: String
}

struct Classification: Decodable {
    let genre: Genre
}

struct Genre: Decodable
{
    let name: String
}
