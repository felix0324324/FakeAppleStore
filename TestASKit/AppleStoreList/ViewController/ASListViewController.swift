//
//  ASListViewController.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import SnapKit
import UIKit
import Foundation
import MJRefresh

class ASListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constaint
    let kTopGrossSection: Int = 0
    let kTopAppSection: Int = 1
    let kDefaultPage: Int = 10
    let kDefaultTimeInterval: TimeInterval = 0.2
    
    // MARK: - UI
    var myASListView: ASListView = ASListView()
    let myHeader = MJRefreshNormalHeader()
    let myFooter = MJRefreshAutoNormalFooter()
    
    // MARK: - Data
    // var myLastOffset: CGPoint = .zero
    var myASListModel: ASListModel?
    var myPage: Int = 0
    var myEntryArray: [Entry] = []
    var myFilterEntryArray: [Entry] = []
    var myTimer: Timer?
    var isFilterMode = false
    var isLoadingMore = false
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupAutolayout()
        self.callAPI()
    }
    
    func setup() {
        self.setupASListView()
        self.setupTextField()
        self.setupTableView()
    }
    
    func setupASListView() {
        myASListView = ASListView()
        self.view.addSubview(self.myASListView)
    }
    
    func setupTextField() {
//        self.myASListView.myTextField.delegate = self
        self.myASListView.myTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func setupTableView() {
        let aTableView = self.myASListView.myTableView
        aTableView.delegate = self
        aTableView.dataSource = self
        
        myHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        aTableView.mj_header = myHeader
        myFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        aTableView.mj_footer = myFooter
    }
    
    // MARK: - SetupAutolayout
    func setupAutolayout() {
        self.myASListView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Common
    func reloadTable() {
        self.myASListView.myTableView.reloadData()
    }
    
    func loadMoreData(isLoadMore: Bool) {
        
        guard self.isLoadingMore != true else { return }
        
        if (!isLoadingMore) {
            isLoadingMore = true
        }
        
        let aFrom = self.myPage * kDefaultPage
        let aTo = (self.myPage + 1) * kDefaultPage
        var aNewCount = 0
        print("ASListViewController loadMoreData - case 1 before myEntryArray : \(self.myEntryArray.count) ")
        if aTo >= (self.myASListModel?.feed?.entry ?? []).count {
            self.myASListView.myTableView.mj_footer?.isHidden = true
            self.myASListView.myTableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            self.myASListView.myTableView.mj_footer?.isHidden = false
            self.myASListView.myTableView.mj_footer?.resetNoMoreData()
        }
        for (i, aEntry) in (self.myASListModel?.feed?.entry ?? []).enumerated() {
            if i >= aFrom && i < aTo {
                self.myEntryArray.append(aEntry)
                aNewCount += 1
            }
        }
        self.myPage += 1
        print("ASListViewController loadMoreData - case 2 after myEntryArray : \(self.myEntryArray.count) ")
        
        if isLoadMore {
            var aIndexArray: [IndexPath] = []
            for aInt in (0..<aNewCount).reversed() {
                let aNum = self.myEntryArray.count - aInt - 1
                let aIndex = IndexPath(row: aNum, section: self.kTopAppSection)
                aIndexArray.append(aIndex)
            }
            
            if aIndexArray.count > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    print("ASListViewController loadMoreData - case 3 after insertRows")
                    self.myASListView.myTableView.beginUpdates()
                    self.myASListView.myTableView.insertRows(at: aIndexArray, with: .right)
                    self.myASListView.myTableView.endUpdates()
                    self.myASListView.myTableView.mj_footer?.endRefreshing()
                    self.isLoadingMore = false
                }
            }
        } else {
            print("ASListViewController loadMoreData - case 4 after insertRows")
            self.reloadTable()
            self.myASListView.myTableView.mj_header?.endRefreshing()
            self.isLoadingMore = false
        }
    }
    
    func clearTimer() {
        if let aTimer = self.myTimer {
            aTimer.invalidate()
            self.myTimer = nil
        }
    }
    
    func startTimer() {
        self.clearTimer()
        self.myTimer = Timer.scheduledTimer(timeInterval: self.kDefaultTimeInterval,
                                            target:self,
                                            selector:#selector(self.textFieldSearch),
                                            userInfo:nil,
                                            repeats:false)
    }
    
    // MARK: - Button Event
    
    @objc func headerRefresh() {
        print("ASListViewController headerRefresh")
        self.myPage = 0
        self.myEntryArray.removeAll()
        Thread.sleep(forTimeInterval: 0.2)
        self.loadMoreData(isLoadMore: false)
    }
    
    @objc func footerRefresh() {
        print("ASListViewController footerRefresh")

        Thread.sleep(forTimeInterval: 0.2)
        self.loadMoreData(isLoadMore: true)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        print("ASListViewController textFieldDidChange - text : \(String(describing: textField.text))")
        self.isFilterMode = textField.text != ""
        self.myASListView.myTableView.mj_footer?.isHidden = self.isFilterMode
        self.startTimer()
        
    }
    
    @objc func textFieldSearch() {
        print("ASListViewController textFieldSearch - text : \(String(describing: self.myASListView.myTextField.text))")
        self.myFilterEntryArray.removeAll()
        if self.isFilterMode {
            // app name, category, author or summary contains the keyword
            for (_ , aEntry) in self.myEntryArray.enumerated() {
                let aLowerCaseText = (self.myASListView.myTextField.text ?? "").lowercased()
                let hvName = aEntry.imName?.label?.lowercased().contains(aLowerCaseText) ?? false
                let hvCategory = aEntry.category?.attributes?.label?.lowercased().contains(aLowerCaseText) ?? false
                let hvSummary = aEntry.summary?.label?.lowercased().contains(aLowerCaseText) ?? false
                if hvName || hvCategory || hvSummary {
                    self.myFilterEntryArray.append(aEntry)
                }
            }
            
//            if self.myLastOffset == .zero {
//                self.myLastOffset = self.myASListView.myTableView.contentOffset
//                print("ASListViewController textFieldSearch - Case 1 : \(self.myLastOffset)")
//            }
        }
            
        self.reloadTable()
        
        // Move Offset
//        Bugs at reload
//        DispatchQueue.main.asyncAfter(deadline: .now() ) {
//            self.myASListView.myTableView.layoutIfNeeded()
//            if self.isFilterMode {
//                self.myASListView.myTableView.setContentOffset(.zero, animated: false)
//                print("ASListViewController textFieldSearch - Case 2 : \(self.myLastOffset) ")
//            } else {
//                self.myASListView.myTableView.setContentOffset(self.myLastOffset, animated: false)
//                self.myLastOffset = .zero
//                print("ASListViewController textFieldSearch - Case 3 : \(self.myLastOffset) ")
//            }
//        }
    }
    
    // MARK: - Call API
    func callAPI() {
        self.callAPIRequestTopFreeApp()
    }
    
    func callAPIRequestTopFreeApp() {
        NetworkingManager.requestTopFreeApp { aASListModel in
            self.myASListModel = aASListModel
            self.reloadTable()
            self.callAPIRequestTopFreeAppDetails(aASListModel: aASListModel)
        }
    }
    
    func callAPIRequestTopFreeAppDetails(aASListModel: ASListModel?) {
        guard let _ = aASListModel else { return }
        for (i, aEntry) in (aASListModel?.feed?.entry ?? []).enumerated() {
            if let aAPPID = aEntry.id?.attributes?.imid {
                NetworkingManager.requestTopFreeAppDetails(appID: aAPPID, compBlock: { aASListDetailModel in
                    self.myASListModel?.feed?.entry?[i].asListDetailModel = aASListDetailModel
                    print("ASListViewController requestTopFreeAppDetails - i : \(i) aAPPID \(aAPPID)") // \(aASListModel?.kj.JSONString())")
                    self.checkAPIAllSuccess(row: i)

                    if i == self.kDefaultPage {
                        self.headerRefresh()
                    }
                })
            }
        }
    }
        
    func checkAPIAllSuccess(row: Int) {
        let aIndexPath = IndexPath(row: row, section: self.kTopAppSection)
        if let cell = self.myASListView.myTableView.cellForRow(at: aIndexPath) as? ASTopAppTableViewCell {
            if let aEntry = self.myASListModel?.feed?.entry?[row] {
                DispatchQueue.main.async {
                    print("ASListViewController checkAPIAllSuccess \(row)")
                    cell.renewEntryModel(entryModel: aEntry)
                }
            }
        }
    }
    
    // MARK: - Delegate
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aCount = 0
        switch section {
        case kTopGrossSection:
            aCount = self.isFilterMode ? 0 : 1
        case kTopAppSection:
            aCount = self.isFilterMode ? self.myFilterEntryArray.count : self.myEntryArray.count
        default:
            break
        }
        return aCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        switch indexPath.section {
            case kTopGrossSection:
                if let aCell = tableView.dequeueReusableCell(withIdentifier: ASCollectionTableViewCell.className, for: indexPath) as? ASCollectionTableViewCell {
                    cell = aCell
                }
            case kTopAppSection:
                if let aCell = tableView.dequeueReusableCell(withIdentifier: ASTopAppTableViewCell.className, for: indexPath) as? ASTopAppTableViewCell {
                    cell = aCell
                    let aArray = self.isFilterMode ? self.myFilterEntryArray : self.myEntryArray
                    let aEntryModel = aArray[indexPath.row]
                    aCell.renewEntryModel(entryModel: aEntryModel)
                    let isSquare = indexPath.row%2 == 0
                    aCell.renewNumLabel(text: String(indexPath.row + 1))
                    aCell.renewIconImage(isCircle: !isSquare)
                }
            default:
                break
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ASListViewController checkAPIAllSuccess - \(indexPath.section)-\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView? = nil
        
        if (section == kTopGrossSection) {
            let aView = UIView()
            aView.backgroundColor = .white
            let aLabel = UILabel()
            aLabel.numberOfLines = 0
            aLabel.font = UIFont.boldSystemFont(ofSize: 20)
            aLabel.text = "推介_"
            aView.addSubview(aLabel)
            
            headerView = aView
            
            aLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.height.greaterThanOrEqualTo(0)
                make.left.right.equalToSuperview().offset(20)
                make.bottom.equalToSuperview().offset(-15)
            }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == kTopGrossSection && !self.isFilterMode) {
            return UITableView.automaticDimension
        }
        return 0.0001
    }
}
