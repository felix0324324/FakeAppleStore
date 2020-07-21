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
    private static let kCellHeight: CGFloat = 80.0
    private static let kIconImageHeight: CGFloat = 60.0
    private static let kLabelMinHeight: CGFloat = 20.0
    
    // MARK: - UI
    var myNumLabel = UILabel()
    var myIconImageView = UIImageView()
    var myTitleLabel = UILabel()
    var mySubTitleLabel = UILabel()
    var myCommendLabel = UILabel()
    var myUnderineView = UIView()
    
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
        self.myNumLabel.backgroundColor = .blue
        self.contentView.addSubview(self.myNumLabel)
    }
    
    private func setupIconImageView() {
//        self.myIconImageView.backgroundColor = .green
        self.myIconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.myIconImageView)
    }
    
    private func setupTitleLabel() {
        self.myTitleLabel.numberOfLines = 0
        self.myTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.myTitleLabel)
    }
    
    private func setupSubTitleLabel() {
        self.mySubTitleLabel.numberOfLines = 0
        self.mySubTitleLabel.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.mySubTitleLabel)
    }
    
    private func setupCommendLabel() {
//        self.myCommendLabel.numberOfLines = 0
        self.myCommendLabel.backgroundColor = UIColor.kGrayColor
        self.myCommendLabel.text = "(0)"
        self.contentView.addSubview(self.myCommendLabel)
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

        self.myCommendLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myTitleLabel.snp.left)
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
        self.renewCommendLabel(text: "")
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
        print("ASTopAppTableViewCell renewTitleLabel - \(text)")
        self.myTitleLabel.text = text
    }
    
    func renewSubTitleLabel(text: String? = "") {
        print("ASTopAppTableViewCell renewSubTitleLabel - \(text)")
        self.mySubTitleLabel.text = text
    }
    
    func renewCommendLabel(text: String? = "") {
        print("ASTopAppTableViewCell renewCommendLabel - \(text)")
        self.myCommendLabel.text = text
    }
}

//extension AIChatCarouselCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.myCarouselModelArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: Self.kCollectionCellWidth, height: collectionView.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var aCell: AIChatCarouselBaseCollectionCell?
//
//        if let data: CarouselModel = self.myCarouselModelArray[safe: indexPath.item] {
//            switch data {
//            case is CarouselPostModel:
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AIChatCarouselPostCollectionCell.className, for: indexPath) as? AIChatCarouselPostCollectionCell {
//                    aCell = cell
//                }
//            case is CarouselNewPropertyModel:
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AIChatCarouselNewPropertyCollectionCell.className, for: indexPath) as? AIChatCarouselNewPropertyCollectionCell {
//                    aCell = cell
//                }
//            case is CarouselEstateModel:
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AIChatCarouselEstateCollectionCell.className, for: indexPath) as? AIChatCarouselEstateCollectionCell {
//                    aCell = cell
//                }
//            case is CarouselBranchModel:
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AIChatCarouselBranchCollectionCell.className, for: indexPath) as? AIChatCarouselBranchCollectionCell {
//                    if cell.delegate == nil {
//                        cell.delegate = self
//                    }
//                    aCell = cell
//                }
//            case is CarouselSearchMoreModel:
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AIChatCarouselSearchMoreCollectionCell.className, for: indexPath) as? AIChatCarouselSearchMoreCollectionCell {
//                    aCell = cell
//                }
//            default:
//                break
//            }
//
//            aCell?.renewData(carouselModel: data)
//        }
//
//        return aCell ?? collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className, for: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let data: CarouselModel = self.myCarouselModelArray[safe: indexPath.item],
//            let collectionCell: AIChatCarouselBaseCollectionCell = collectionView.cellForItem(at: indexPath) as? AIChatCarouselBaseCollectionCell {
//            self.delegate?.carouselCell(self, collectionCell: collectionCell, didSelectCarousel: data)
//        }
//    }
//}
//
//extension AIChatCarouselCell: AIChatCarouselBranchCollectionCellDelegate {
//    func phoneBtnPress(collectionCell: AIChatCarouselBranchCollectionCell) {
//        if let aIndexPath: IndexPath = self.myCollectionView.indexPath(for: collectionCell),
//            let model:CarouselBranchModel = myCarouselModelArray[safe: aIndexPath.item] as? CarouselBranchModel {
//            delegate?.carouselCell(self, collectionCell: collectionCell, didPressPhone: model)
//        }
//    }
//
//    func mapBtnPress(collectionCell: AIChatCarouselBranchCollectionCell) {
//        if let aIndexPath: IndexPath = self.myCollectionView.indexPath(for: collectionCell),
//            let model:CarouselBranchModel = myCarouselModelArray[safe: aIndexPath.item] as? CarouselBranchModel {
//            delegate?.carouselCell(self, collectionCell: collectionCell, didPressMap: model)
//        }
//    }
//}
