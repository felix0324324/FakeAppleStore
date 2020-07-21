//
//  ASBlankTableViewCell.swift
//
//  Created by Alvis on 2020/6/11.
//  Copyright © 2020  Property. All rights reserved.
//

import UIKit
import SnapKit

class ASBlankTableViewCell: UITableViewCell {
    // MARK: - Constaint
      private static let kCellHeight: CGFloat = 120.0
//    private static let kCollectionCellWidth: CGFloat = 200.0
//    private static let kCollectionViewBottomSpacing: CGFloat = 10.0
//    private static let kCollectionViewInteritemLeftRightSpacing: CGFloat = 15.0
    
    // MARK: - UI
//    private var myCollectionView: UICollectionView!
    
    // MARK: - Data
//    weak var delegate: AIChatCarouselCellDelegate?
//    private var myCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//    private var myCollectionViewHeightConst: Constraint?
//    private var myCarouselModelArray: [CarouselModel] = [CarouselModel]()
    
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
//        self.setupCollectionView()
        self.setupAutolayout()
    }
    
    private func setupSelf() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .red
    }
//
//    private func setupCollectionView() {
//        self.myCollectionViewLayout.minimumLineSpacing = Self.kCollectionViewInteritemLeftRightSpacing
//        self.myCollectionViewLayout.scrollDirection = .horizontal
//        self.myCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0,
//                                                                left: Self.kCollectionViewInteritemLeftRightSpacing,
//                                                                bottom: 0,
//                                                                right: Self.kCollectionViewInteritemLeftRightSpacing)
////        self.myCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        self.myCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.myCollectionViewLayout)
//        self.myCollectionView.delegate = self
//        self.myCollectionView.dataSource = self
//        self.myCollectionView.backgroundColor = .white
//        self.myCollectionView.showsVerticalScrollIndicator = false
//        self.myCollectionView.showsHorizontalScrollIndicator = false
//
//        let aCellClassArray: [(AnyObject.Type, String)] = [(AIChatCarouselPostCollectionCell.self,
//                                                            AIChatCarouselPostCollectionCell.className),
//                                                           (AIChatCarouselSearchMoreCollectionCell.self,
//                                                            AIChatCarouselSearchMoreCollectionCell.className),
//                                                           (AIChatCarouselNewPropertyCollectionCell.self,
//                                                            AIChatCarouselNewPropertyCollectionCell.className),
//                                                           (AIChatCarouselEstateCollectionCell.self,
//                                                            AIChatCarouselEstateCollectionCell.className),
//                                                           (AIChatCarouselBranchCollectionCell.self,
//                                                            AIChatCarouselBranchCollectionCell.className),
//                                                           (UICollectionViewCell.self,
//                                                            UICollectionViewCell.className)]
//        self.myCollectionView.registerCells(aCellClassArray)
//
//        self.contentView.addSubview(self.myCollectionView)
//    }
//
    func setupAutolayout() {
        self.contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(Self.kCellHeight)
        }
        
//        self.contentView.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalToSuperview()
//            make.height.equalToSuperview().offset(Self.kCellHeight)
//            self.myCollectionViewHeightConst = make.height.equalTo(0).priority(.low).constraint
//        }
        
//        self.myCollectionView.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(self.contentView)
//            make.bottom.equalTo(self.contentView).offset(-Self.kCollectionViewBottomSpacing)
//            self.myCollectionViewHeightConst = make.height.equalTo(0).priority(.low).constraint
//        }
    }
//
//    // MARK: - Renew
//    func renew(messageEventHistoryModel: AIChatBotHistoryModel.MessageEventHistoryModel) {
//        self.myCarouselModelArray.removeAll()
//        self.myCarouselModelArray.append(contentsOf: messageEventHistoryModel.data?.carouselModels ?? [])
//
//        var aCardHeight: CGFloat = 0.0
//        if let type: String = messageEventHistoryModel.data?.themeType {
//            switch type {
//            case "Rent", "Sale":
//                aCardHeight = AIChatCarouselPostCollectionCell.kCellHeight
//            case "NewProperty":
//                aCardHeight = messageEventHistoryModel.data?.carouselModels?.first?.locale == .en_US ? AIChatCarouselNewPropertyCollectionCell.kEnCellHeight : AIChatCarouselNewPropertyCollectionCell.kZhCellHeight
//            case "Estate":
//                aCardHeight = messageEventHistoryModel.data?.carouselModels?.first?.locale == .en_US ? AIChatCarouselEstateCollectionCell.kEnCEllHeight : AIChatCarouselEstateCollectionCell.kZhCellHeight
//            case "Branch":
//                aCardHeight = AIChatCarouselBranchCollectionCell.kCellHeight
//            default:
//                break
//            }
//        }
//        self.myCollectionViewHeightConst?.update(offset: aCardHeight + AIChatCarouselBaseCollectionCell.kContentTopPadding + AIChatCarouselBaseCollectionCell.kContentBottomPadding)
//
//        self.myCollectionView.reloadData()
//        self.myCollectionView.setContentOffset(.zero, animated: false)
//    }
    
//    // MARK: - Touch Function
//    @objc func touchedContentView() {
//        print("AIChatCarouselCell touchedContentView")
//        self.delegate?.carouselCellDidPressContentView()
//    }
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
