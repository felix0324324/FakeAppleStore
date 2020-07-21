//
//  ASCollectionViewCell.swift
//
//  Created by Alvis Lam on 12/6/2020.
//  Copyright © 2020 Centaline Property. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class ASCollectionViewCell: UICollectionViewCell {
    // MARK: - Constaint
    static let kShadowColor: UIColor = .black
    static let kContentViewCornerRadius: CGFloat = 18.0
    static let kContentTopPadding: CGFloat = 10.0
    static let kContentBottomPadding: CGFloat = 15.0
    static let kIconImageViewCornerRadius: CGFloat = 8.0
    
    
    // MARK: - UI
    let myIconImageView: UIImageView = UIImageView()
    var myTitleLabel = UILabel()
    var mySubTitleLabel = UILabel()
    
    // MARK: - Data
    
    // MARK: - Init Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        self.setupAutolayout()
    }
    
    // MARK: - Setup
    func setup() {
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupSubTitleLabel()
    }

    private func setupIconImageView() {
        // self.myIconImageView.backgroundColor = .green
        self.myIconImageView.layer.cornerRadius = Self.kIconImageViewCornerRadius
        self.myIconImageView.clipsToBounds = true
        self.contentView.addSubview(self.myIconImageView)
    }
    
    private func setupTitleLabel() {
        self.myTitleLabel.numberOfLines = 0
        self.myTitleLabel.font = UIFont.systemFont(ofSize: 10)
        // self.myTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.myTitleLabel)
    }
    
    private func setupSubTitleLabel() {
        self.mySubTitleLabel.numberOfLines = 0
        self.mySubTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.mySubTitleLabel.textColor = UIColor.kGray2Color
        // self.mySubTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.mySubTitleLabel)
    }
    
    // MARK: - SetupAutolayout
    func setupAutolayout() {
        
        self.myIconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(self.contentView.snp.width).multipliedBy(0.9)
        }
        
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.myIconImageView).inset(-2)
            make.top.equalTo(self.myIconImageView.snp.bottom).offset(4)
            make.height.greaterThanOrEqualTo(0)
        }

        self.mySubTitleLabel.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.myTitleLabel)
            make.top.equalTo(self.myTitleLabel.snp.bottom).offset(4)
            make.height.greaterThanOrEqualTo(0)
        }
    }
    
    // MARK: - Renew
    func renewEntryModel(entryModel: Entry) {
        if let aURLString = entryModel.imImage?.last?.label, let aURL = URL.init(string: aURLString) {
            self.renewIconImageView(url: aURL)
        }
        self.renewTitleLabel(text: entryModel.imName?.label)
        self.renewSubTitleLabel(text: entryModel.category?.attributes?.label)
        self.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
    }
    
    func renewIconImageView(url: URL) {
        SDWebImageDownloader.shared.downloadImage(with: url, completed: { (image, error, cacheType, imageURL) in
            self.myIconImageView.image = image
            self.layoutIfNeeded()
        })
    }
    
    func renewTitleLabel(text: String? = "") {
        // print("ASTopAppTableViewCell renewTitleLabel - \(String(describing: text))")
        self.myTitleLabel.text = text
    }
    
    func renewSubTitleLabel(text: String? = "") {
        // print("ASTopAppTableViewCell renewSubTitleLabel - \(String(describing: text))")
        self.mySubTitleLabel.text = text
    }
}
