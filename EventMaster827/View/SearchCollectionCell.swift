//
//  SearchCollectionCell.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SearchCollectionCell: UICollectionViewCell {
   
    @IBOutlet weak var attrImage: UIImageView!
    static let identifier = "SearchCollectionCell"
    
    
    var attr: Attraction! {
        didSet {
            attr.getImage { [weak self] image in
                self?.attrImage.image = image
            }
        }
    }

}
