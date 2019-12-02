//
//  FireManager.swift
//  EventMaster827
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FireManager {
    
    static let shared = FireManager()
    private init() {}
    
    
    let userRef = Database.database().reference(withPath: "user")
    lazy var bookMarksRef = userRef.child("bookMark")
    
    
    //MARK: Save
    func save(_ attr: Attraction) {
        //attr properties and set them individually
        bookMarksRef.child(attr.id).setValue(attr.toDictionary)
        print("Saved Attraction to Firebase: \(attr.id)")
    }
    
    
    //MARK: Delete
    func remove(_ attr: Attraction) {
        bookMarksRef.child(attr.id).removeValue()
        print("Removed Attraction From Firebase: \(attr.id)")
        
    }
    
    //MARK: Load
    func load(completion: @escaping ([Attraction]) -> Void) {
        
        bookMarksRef.observeSingleEvent(of: .value) { snapshot in
            var attractions = [Attraction]()
            
            for snap in snapshot.children {
                
                let dataSnap = snap as! DataSnapshot
                if let attr = Attraction(from: dataSnap) {
                    attractions.append(attr)
                }
            }
            
            completion(attractions)
        }
        
        
    }
    
    
}
