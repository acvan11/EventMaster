//
//  BookmarkViewController.swift
//  EventMaster827
//
//  Created by mac on 10/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var bookMarkTableView: UITableView!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBookmark()
    }
    
    
    private func setupBookmark() {
        
        bookMarkTableView.register(UINib(nibName: AttractionTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: AttractionTableCell.identifier)
        
        bookMarkTableView.tableFooterView = UIView(frame: .zero)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.bookMarkNotification, object: nil, queue: .main) { [weak self] _ in
            self?.bookMarkTableView.reloadData()
        }
    }
    
    @objc private func favoriteTapped(sender: UIButton) {
        
        let attr = getAttrFromSet(sender.tag)
        
        let isSelected = sender.tintColor == UIColor.red ? false : true
        sender.tintColor = isSelected ? .lightGray : .red
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            switch isSelected {
            case true:
               FireManager.shared.remove(attr)
               self.viewModel.bookMarks.remove(attr)
            case false:
                break
            }
        }
    }
    
    private func getAttrFromSet(_ row: Int) -> Attraction {
        let index = viewModel.bookMarks.index(viewModel.bookMarks.startIndex, offsetBy: row)
        return viewModel.bookMarks[index]
    }


}

extension BookmarkViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookMarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttractionTableCell.identifier, for: indexPath) as! AttractionTableCell
        
        let attr = getAttrFromSet(indexPath.row)
        
        cell.favoriteButton.tintColor = .red
        cell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(sender:)), for: .touchUpInside)
        cell.favoriteButton.tag = indexPath.row
        
        cell.attr = attr
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
