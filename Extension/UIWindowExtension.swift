//
//  UIWindowExtension.swift
//  MapController
//
//  Created by Lloyd Fung on 16/5/2018.
//  Copyright © 2018年  Property. All rights reserved.
//

import UIKit
import Foundation

extension UIWindow {
    static var keySafeAreaTop: CGFloat {
        let top = keySafeAreaInsets.top
        // For status bar 20px
        return top == 0 ? 20 : top
    }
    
    static var keySafeAreaBottom: CGFloat {
        return keySafeAreaInsets.bottom
    }
    
    static var keySafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets
            return safeAreaInsets ?? UIEdgeInsets.zero
        }
        return UIEdgeInsets.zero
    }
}
