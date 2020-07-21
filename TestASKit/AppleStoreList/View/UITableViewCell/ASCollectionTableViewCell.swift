//
//  ASCollectionTableViewCell.swift
//
//  Created by Alvis on 2020/6/11.
//  Copyright © 2020  Property. All rights reserved.
//

import UIKit
import SnapKit

class ASCollectionTableViewCell: UITableViewCell {
    // MARK: - Constaint
    private static let kCellLeftRightSpace: CGFloat = 20.0
    private static let kCollectionCellWidth: CGFloat = 80.0
    private static let kCollectionCellHeight: CGFloat = 150.0
    
    // MARK: - UI
    private var myCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var myCollectionView: UICollectionView!
    
    // MARK: - Data
    var myASListModel: ASListModel?
    
    // MARK: - Init Function
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.callAPI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        self.callAPI()
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupSelf()
        self.setupCollectionView()
        self.setupAutolayout()
    }
    
    private func setupSelf() {
        self.selectionStyle = .none
         self.contentView.backgroundColor = .red
    }

    private func setupCollectionView() {
        self.myCollectionViewLayout.minimumLineSpacing = Self.kCellLeftRightSpace
        self.myCollectionViewLayout.scrollDirection = .horizontal
        self.myCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0,
                                                                left: Self.kCellLeftRightSpace,
                                                                bottom: 0,
                                                                right: Self.kCellLeftRightSpace)
        self.myCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.myCollectionViewLayout)
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.myCollectionView.backgroundColor = .white
        self.myCollectionView.showsVerticalScrollIndicator = false
        self.myCollectionView.showsHorizontalScrollIndicator = false
        
        let aCellClassArray: [(AnyObject.Type, String)] = [(ASCollectionViewCell.self,
                                                            ASCollectionViewCell.className),
                                                           (UICollectionViewCell.self,
                                                            UICollectionViewCell.className)]
        for (type, identifier) in aCellClassArray {
            self.myCollectionView.register(type, forCellWithReuseIdentifier: identifier)
        }
        self.contentView.addSubview(self.myCollectionView)
    }
    
    // MARK: - setupAutolayout
    func setupAutolayout() {
        self.myCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(Self.kCollectionCellHeight)
        }
    }
    
    // MARK: - Call API
    func callAPI() {
        self.callAPIRequestTopGrossApp()
    }
    
    func callAPIRequestTopGrossApp() {
        NetworkingManager.requestTopGrossApp { aASListModel in
            self.myASListModel = aASListModel
            self.myCollectionView.reloadData()
        }
    }
    
    // MARK: - Renew
}

extension ASCollectionTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myASListModel?.feed?.entry?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Self.kCollectionCellWidth, height: Self.kCollectionCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var aCell: ASCollectionViewCell?

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASCollectionViewCell.className, for: indexPath) as? ASCollectionViewCell {
            aCell = cell
            if let aEntry = self.myASListModel?.feed?.entry?[indexPath.row] {
                cell.renewEntryModel(entryModel: aEntry)
            }
        }

        return aCell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ASCollectionTableViewCell collectionView : \(indexPath.section) - \(indexPath.row)")
    }
}
