//
//  ASListViewController.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import SnapKit
import UIKit
import Foundation

class ASListViewController: UIViewController {
    
    // MARK: - UI
    var myASListView: ASListView! = nil
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup() {
        self.setupASListView()
    }
    
    func setupASListView() {
        myASListView = ASListView()
        self.myASListView.backgroundColor = .red
        self.view.addSubview(self.myASListView)
        
        self.myASListView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
    }
}
