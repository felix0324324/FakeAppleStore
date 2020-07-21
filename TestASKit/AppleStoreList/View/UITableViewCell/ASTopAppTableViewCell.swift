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
        self.setupUnderLineView()
        
        self.setupAutolayout()
    }
    
    private func setupSelf() {
        self.selectionStyle = .none
    }
    
    private func setupNumLabel() {
        self.myNumLabel.textColor = UIColor.black
        self.myNumLabel.textAlignment = .center
        self.myNumLabel.backgroundColor = .blue
        self.contentView.addSubview(self.myNumLabel)
    }
    
    private func setupIconImageView() {
        self.myIconImageView.backgroundColor = .green
        self.myIconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.myIconImageView)
    }
    
    private func setupUnderLineView() {
        self.myUnderineView.backgroundColor = UIColor.kGrayColor
        self.contentView.addSubview(self.myUnderineView)
    }
    
    // MARK: - setupAutolayout
    func setupAutolayout() {
        self.contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(Self.kCellHeight)
        }

        self.myNumLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(40)
            make.top.bottom.equalToSuperview()
        }
        
        self.myIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.myNumLabel.snp.right).offset(10)
            make.height.width.equalTo(Self.kIconImageHeight)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            // make.right.equalToSuperview().offset(0)
        }
        
        self.myUnderineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Renew
    func renewNumLabel(text: String) {
        print("renewNumLabel - \(text)")
        self.myNumLabel.text = text
    }
    
    func renewIconImage(isCircle: Bool) {
        self.myIconImageView.layer.cornerRadius = isCircle ? Self.kIconImageHeight/2 : 8
        self.myIconImageView.clipsToBounds = true
    }
    
    func renewEntryModel(entryModel: Entry) {
        if let aURLString = entryModel.imImage?.last?.label, let aURL = URL.init(string: aURLString) {
            SDWebImageDownloader.shared.downloadImage(with: aURL, completed: { (image, error, cacheType, imageURL) in
                self.myIconImageView.image = image
                self.layoutIfNeeded()
            })
        }
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
