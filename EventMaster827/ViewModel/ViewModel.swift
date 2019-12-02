//
//  ViewModel.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol AttrDelegate: class {
    func update()
}

class ViewModel {
    
    weak var attrDelegate: AttrDelegate?
    
    var attrs = [Attraction]() {
        didSet {
            attrDelegate?.update()
        }
    }
    
    var bookMarks = Set<Attraction>() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.bookMarkNotification, object: nil)
        }
    }
    
    func getAttr() {
        MasterService.shared.getAttractions { [weak self] atr in
            self?.attrs = atr
            print("Attr Count: \(atr.count)")
        }
    }
    
    func loadBookmarks() {
        FireManager.shared.load { [weak self] attrs in
            self?.bookMarks = Set<Attraction>(attrs)
            print("Bookmark Count: \(attrs.count)")
        }
    }
}
