//
//  ViewController.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
    }

    private func setupHome() {
        viewModel.attrDelegate = self
        homeTableView.register(UINib(nibName: AttractionTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: AttractionTableCell.identifier)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.bookMarkNotification, object: nil, queue: .main) { [weak self] _ in
            self?.homeTableView.reloadData()
        }
    }
    
    private func goToRow(_ index: IndexPath) {
        homeTableView.selectRow(at: index, animated: true, scrollPosition: .top)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.homeTableView.deselectRow(at: index, animated: true)
        }
    }

}


// MARK: - Table View Stack
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // '1' for collection view, else '3'
        return section == 0 ? 1 : viewModel.attrs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCellOne.identifier, for: indexPath) as! SearchTableCellOne
            cell.searchCollectionView.reloadData()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AttractionTableCell.identifier, for: indexPath) as! AttractionTableCell
            let attr = viewModel.attrs[indexPath.row]
            cell.favoriteButton.tintColor = viewModel.bookMarks.contains(attr) ? UIColor.red : UIColor.lightGray
            cell.delegate = self
            cell.attr = attr
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Collection View Stack
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.attrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionCell.identifier, for: indexPath) as! SearchCollectionCell
        let attr = viewModel.attrs[indexPath.row]
        cell.attr = attr
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3.5
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = IndexPath(row: indexPath.row, section: 1)
        goToRow(index)

    }
}

//MARK: AttrDelegate

extension HomeViewController: AttrDelegate {
    func update() {
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
}

//MARK: AttractionCellDelegate

extension HomeViewController: AttractionCellDelegate {
    
    
    func pass(cell: AttractionTableCell) {
        //get indexPath for cell passed from delegate
        guard let index = homeTableView.indexPath(for: cell) else {
            return
        }
        let attr = viewModel.attrs[index.row]
        
        switch cell.favoriteButton.tintColor {
        case UIColor.red:
            FireManager.shared.save(attr)
            viewModel.bookMarks.insert(attr)
        case UIColor.lightGray:
            FireManager.shared.remove(attr)
            viewModel.bookMarks.remove(attr)
        default:
            break
        }
    }
}
