//
//  ASTopAppTableViewCell.swift
//
//  Created by Alvis on 2020/6/11.
//  Copyright © 2020  Property. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ASTopAppTableViewCell: UITableViewCell {
    
    // MARK: - Constaint
    private static let kIconImageHeight: CGFloat = 60.0
    private static let kLabelMinHeight: CGFloat = 20.0
    private static let kStarHeight: CGFloat = 14.0
    private static let kTotalStar: Int = 5
    
    // MARK: - UI
    var myNumLabel = UILabel()
    var myIconImageView = UIImageView()
    var myTitleLabel = UILabel()
    var mySubTitleLabel = UILabel()
    var myCommendLabel = UILabel()
    var myUnderineView = UIView()
    var myStarView : [UIView] = []
    
    // MARK: - Data
    
    // MARK: - Init Function
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupSelf()
        self.setupNumLabel()
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupSubTitleLabel()
        self.setupCommendLabel()
        self.setupStarView()
        self.setupUnderLineView()
        
        self.setupAutolayout()
    }
    
    private func setupSelf() {
        self.selectionStyle = .none
    }
    
    private func setupNumLabel() {
        self.myNumLabel.numberOfLines = 0
        self.myNumLabel.textColor = UIColor.black
        self.myNumLabel.textAlignment = .center
        // self.myNumLabel.backgroundColor = .blue
        self.contentView.addSubview(self.myNumLabel)
    }
    
    private func setupIconImageView() {
        //self.myIconImageView.backgroundColor = .green
        self.myIconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.myIconImageView)
    }
    
    private func setupTitleLabel() {
        self.myTitleLabel.numberOfLines = 0
        // self.myTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.myTitleLabel)
    }
    
    private func setupSubTitleLabel() {
        self.mySubTitleLabel.numberOfLines = 0
        // self.mySubTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.mySubTitleLabel)
    }
    
    private func setupCommendLabel() {
        self.myCommendLabel.numberOfLines = 0
        // self.myCommendLabel.backgroundColor = UIColor.kGrayColor
        self.myCommendLabel.text = "(0)"
        self.contentView.addSubview(self.myCommendLabel)
    }
    
    private func setupStarView() {
        self.myStarView.removeAll()
        for _ in 0...(Self.kTotalStar - 1) {
            let aView = UIView.init()
            aView.backgroundColor = .kStarColor
            aView.layer.borderWidth = 1
            aView.layer.borderColor = UIColor.kStarColor.cgColor
            self.myStarView.append(aView)
            self.contentView.addSubview(aView)
        }
    }
    
    private func setupUnderLineView() {
        self.myUnderineView.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.myUnderineView)
    }
    
    
    // MARK: - setupAutolayout
    func setupAutolayout() {

        self.myNumLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(40)
            make.top.bottom.equalToSuperview()
        }

        self.myIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.myNumLabel.snp.right).offset(10)
            make.height.width.equalTo(Self.kIconImageHeight)
            make.top.equalToSuperview().offset(10)
        }
        
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(self.myIconImageView.snp.right).offset(10)
            make.height.greaterThanOrEqualTo(Self.kLabelMinHeight)
            make.top.equalToSuperview().offset(4)
        }

        self.mySubTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myTitleLabel.snp.left)
            make.top.equalTo(self.myTitleLabel.snp.bottom).offset(4)
            make.right.equalTo(self.myTitleLabel.snp.right)
            make.height.greaterThanOrEqualTo(Self.kLabelMinHeight)
        }
        
        for (i, aView) in self.myStarView.enumerated() {
            aView.snp.makeConstraints { (make) in
                make.left.equalTo(self.myIconImageView.snp.right).offset(10 + (i * Int(Self.kStarHeight + 4)))
                make.height.width.equalTo(Self.kStarHeight)
                make.top.equalTo(self.mySubTitleLabel.snp.bottom).offset(8)
            }
        }

        self.myCommendLabel.snp.makeConstraints { (make) in
            if let aView = self.myStarView.last {
                make.left.equalTo(aView.snp.right).offset(4)
            }
            make.top.equalTo(self.mySubTitleLabel.snp.bottom).offset(4)
            make.right.equalTo(self.myTitleLabel.snp.right)
            make.height.greaterThanOrEqualTo(Self.kLabelMinHeight)
            make.bottom.equalToSuperview()
        }
        
        self.myUnderineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Renew
    func renewNumLabel(text: String) {
        print("ASTopAppTableViewCell renewNumLabel - \(text)")
        self.myNumLabel.text = text
    }
    
    func renewIconImage(isCircle: Bool) {
        self.myIconImageView.layer.cornerRadius = isCircle ? Self.kIconImageHeight/2 : 8
        self.myIconImageView.clipsToBounds = true
    }
    
    func renewEntryModel(entryModel: Entry) {
        if let aURLString = entryModel.imImage?.last?.label, let aURL = URL.init(string: aURLString) {
            self.renewIconImageView(url: aURL)
        }
        self.renewTitleLabel(text: entryModel.imName?.label)
        self.renewSubTitleLabel(text: entryModel.category?.attributes?.label)
        let aStarFloat = entryModel.asListDetailModel?.results?.first?.averageUserRatingForCurrentVersion ?? 0
        let aStarInt = Int(aStarFloat)
        self.renewStar(int: aStarInt)
        let aUserRatingCount = entryModel.asListDetailModel?.results?.first?.userRatingCount ?? 0
        self.renewCommendLabel(text: "(\(aUserRatingCount))")
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
    
    func renewCommendLabel(text: String? = "") {
        // print("ASTopAppTableViewCell renewCommendLabel - \(String(describing: text))")
        self.myCommendLabel.text = text
    }
    
    func renewStar(int: Int) {
        // print("ASTopAppTableViewCell renewStar - \(int)")
        var aMaxInt = int
        if int > Self.kTotalStar {
            aMaxInt = Self.kTotalStar
        }
        
        for (i, aView) in self.myStarView.enumerated() {
            aView.backgroundColor = i < aMaxInt ? UIColor.kStarColor : UIColor.white
        }
    }
}
