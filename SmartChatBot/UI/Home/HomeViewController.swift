//
//  HomeViewController.swift
//  SmartChatBot
//
//  Created by Kostis on 21/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func presentTVChatViewController() {
        let viewController = ChatViewController(nibName: ChatViewController.nibName, bundle: nil)
        present(viewController, animated: true, completion: nil)
    }
    
    //Outlet Actions
    @IBAction fileprivate func openChatPressed(_ sender: Any) {
        presentTVChatViewController()
    }
}
