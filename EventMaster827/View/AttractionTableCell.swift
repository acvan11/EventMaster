//
//  AttractionTableCell.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol AttractionCellDelegate: class {
    func pass(cell: AttractionTableCell)
}

class AttractionTableCell: UITableViewCell {

    @IBOutlet weak var attractionImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: AttractionCellDelegate?
    

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        var isSelected = sender.tintColor == UIColor.red ? true : false
        isSelected.toggle()
        
        switch isSelected {
        case true:
            sender.tintColor = UIColor.red
        case false:
            sender.tintColor = UIColor.lightGray
        }
        
        delegate?.pass(cell: self)
    }
    
    static let identifier = "AttractionTableCell"
    
    var attr: Attraction! {
        didSet {
            attr.getImage { [weak self] image in
                self?.attractionImage.image = image
            }
            mainLabel.text = attr.name
            subLabel.text = attr.classifications.first!.genre.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //edit the color progamatically
        let starImage = #imageLiteral(resourceName: "star").withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(starImage, for: .normal)
    }
    
    //function is called right before rendering a new cell
    override func prepareForReuse() {
        super.prepareForReuse()
        attractionImage.image = nil
    }
    
    
}
