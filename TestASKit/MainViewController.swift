//
//  MainViewController.swift
//  TestASKit
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - UI
    var myASListViewController: ASListViewController! = nil
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.setupASListViewController()
    }
    
    func setupASListViewController() {
        myASListViewController = ASListViewController.init()
        self.view.addSubview(self.myASListViewController.view)
    }
    
    // MARK: - Call API
    func callAPIRequestTopFreeApp(){
        NetworkingManager.requestTopFreeApp { aModel in
            print("MainViewController requestTopFreeApp - \(aModel?.kj.JSONString())")
        }
    }
}

