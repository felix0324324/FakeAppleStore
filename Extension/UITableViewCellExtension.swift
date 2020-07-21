//
//  UITableViewCellExtension.swift
//
//  Created by Alvis on 26/11/2019.
//  Copyright © 2018年  Property. All rights reserved.
//

import UIKit
import Foundation

extension UITableViewCell {
    
    class var className: String {
        return String(describing: self)
    }
}
