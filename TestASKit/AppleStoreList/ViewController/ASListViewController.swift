//
//  ASListViewController.swift
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import SnapKit
import UIKit
import Foundation

class ASListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constaint
    let kTopGrossSection: Int = 0
    let kTopAppSection: Int = 1
    
    // MARK: - UI
    var myASListView: ASListView = ASListView()
    var myASListModel: ASListModel?
    
    // MARK: - Data
    var myDataArray: [String] = ["123","321"]
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupAutolayout()
        self.callAPI()
    }
    
    func setup() {
        self.setupASListView()
    }
    
    func setupASListView() {
        myASListView = ASListView()
        self.myASListView.myTableView.delegate = self
        self.myASListView.myTableView.dataSource = self
        self.view.addSubview(self.myASListView)
    }
    
    // MARK: - SetupAutolayout
    func setupAutolayout() {
        self.myASListView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Call API
    func callAPI() {
        self.callAPIRequestTopFreeApp()
    }
    
    func callAPIRequestTopFreeApp() {
        NetworkingManager.requestTopFreeApp { aASListModel in
            self.myASListModel = aASListModel
            self.myASListView.myTableView.reloadData()
            // print("MainViewController requestTopFreeApp - \(aASListModel?.kj.JSONString())")
        }
    }
    
    // MARK: - Delegate
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aCount = 0
        switch section {
        case kTopGrossSection:
            aCount = 1
        case kTopAppSection:
            if let aEntry = self.myASListModel?.feed?.entry?.count {
                aCount = aEntry
            }
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
//                    if let aName = self.myASListModel?.feed?.entry?[indexPath.row].title {
//                        // aCell.textLabel?.text = aName.label
//                    }
                    if let aEntryModel = self.myASListModel?.feed?.entry?[indexPath.row] {
                        aCell.renewEntryModel(entryModel: aEntryModel)
                    }
                    let isSquare = indexPath.row%2 == 0
                    aCell.renewNumLabel(text: String(indexPath.row + 1))
                    aCell.renewIconImage(isCircle: !isSquare)
                }
            default:
                break
        }
            
//            aCell.contentView.snp.makeConstraints { make in
//                make.top.equalToSuperview().offset(30)
//                make.left.equalToSuperview().offset(10)
//                make.height.equalTo(100)
//                make.right.equalToSuperview().offset(-10)
//            }

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
        let title = section == kTopGrossSection ? "推介_" : " "
        return title
    }
    
}
