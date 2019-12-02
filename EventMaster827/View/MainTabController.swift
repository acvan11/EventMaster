//
//  MainTabController.swift
//  EventMaster827
//
//  Created by mac on 10/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMain()
    }
    
    private func setupMain() {
        
        //loop through TabBarController Children VCs
        for controller in viewControllers! {
            guard let navController = controller as? UINavigationController else { return }
            let viewController = navController.topViewController!
            if let homeVC = viewController as? HomeViewController {
                homeVC.viewModel = viewModel
            } else if let bookmarkVC = viewController as? BookmarkViewController {
                bookmarkVC.viewModel = viewModel
            }
        }
        
        viewModel.loadBookmarks()
        viewModel.getAttr()
        
    }

}
