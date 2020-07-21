//
//  ASListView.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import UIKit
import Foundation

class ASListView: UIView {
    
    let kTextFieldCornerRadius: CGFloat = 8
    
    // MARK: - UI
    let myTextField: UITextField = UITextField()
    let myTableView: UITableView = UITableView()
    
    
    
    
    // MARK: - Init Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.setup()
//        self.setupAutoLayout()
    }
    
    // MARK: - Setup
    func setup() {
        self.setupTextField()
        self.setupTableView()
    }
    
    func setupTextField() {
        myTextField.backgroundColor = UIColor.kSearchBarColor
        self.myTextField.layer.cornerRadius = kTextFieldCornerRadius
        self.myTextField.placeholder = "搜尋_"
        self.myTextField.leftViewMode = .always
        
        let aLeftImageView = UIImageView();
        aLeftImageView.backgroundColor = UIColor.red
        self.myTextField.leftView = aLeftImageView
        self.addSubview(self.myTextField)
    }
    
    func setupTableView() {
        // myTableView.backgroundColor = UIColor.brown
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        self.myTableView.register(ASBlankTableViewCell.self, forCellReuseIdentifier: ASBlankTableViewCell.className)
        self.myTableView.register(ASTopAppTableViewCell.self, forCellReuseIdentifier: ASTopAppTableViewCell.className)
        
        self.myTableView.keyboardDismissMode = .onDrag
        self.myTableView.separatorStyle = .none
        self.addSubview(self.myTableView)
    }
    
    // MARK: - setupAutoLayout
    func setupAutoLayout() {
        
        self.myTextField.leftView?.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        self.myTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-10)
        }

        self.myTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.myTextField.snp_bottomMargin).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
}
