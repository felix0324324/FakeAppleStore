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
    let kDefaultTimeInterval: TimeInterval = 0.5
    
    // MARK: - UI
    var myASListView: ASListView = ASListView()
    let myHeader = MJRefreshNormalHeader()
    let myFooter = MJRefreshAutoNormalFooter()
    
    // MARK: - Data
    var myASListModel: ASListModel?
    var myPage: Int = 0
    var myEntryArray: [Entry] = []
    var isFilterMode = false
    var myFilterEntryArray: [Entry] = []
    var myTimer : Timer?
    
    
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
    
    func loadMoreData() {
        let aFrom = self.myPage * kDefaultPage
        let aTo = (self.myPage + 1) * kDefaultPage
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
            }
        }
        self.myPage += 1
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
        self.loadMoreData()
        Thread.sleep(forTimeInterval: 0.5)
        let aTableView = self.myASListView.myTableView
        self.reloadTable()
        aTableView.mj_header?.endRefreshing()
    }
    
    @objc func footerRefresh() {
        print("ASListViewController footerRefresh")

        self.loadMoreData()
        Thread.sleep(forTimeInterval: 0.5)
        let aTableView = self.myASListView.myTableView
        self.reloadTable()
        aTableView.mj_footer?.endRefreshing()
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        print("ASListViewController textFieldDidChange - text : \(String(describing: textField.text))")
        self.startTimer()
        self.isFilterMode = textField.text != ""
        self.myASListView.myTableView.mj_footer?.isHidden = self.isFilterMode
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
        }
        self.reloadTable()
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
                if let aCell = tableView.dequeueReusableCell(withIdentifier: ASBlankTableViewCell.className, for: indexPath) as? ASBlankTableViewCell {
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
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = section == kTopGrossSection ? "推介_" : ""
        return title
    }
    
}
