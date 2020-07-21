//
//  UIColor.swift
//
//  Created by Lloyd Fung on 25/4/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    static let kSearchBarColor = UIColor.getColorFromRGB(r: 228, g: 229, b: 230)
    static let kGrayColor = UIColor.getColorFromRGB(r: 228, g: 229, b: 230)
    static let kStarColor = UIColor.getColorFromRGB(r: 254, g: 149, b: 0)
    
    static func getColorFromRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
