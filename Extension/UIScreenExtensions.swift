//
//  UIScreenExtension.swift
//  TestProj36-AsynDisplayKit
//
//  Created by Lloyd Fung on 25/4/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

import UIKit
import Foundation

extension UIScreen {
    static var width: CGFloat {
        return main.bounds.width
    }
    
    static var height: CGFloat {
        return main.bounds.height
    }
    
    static var navigationBarHeight: CGFloat {
        return 44
    }
    
    static var topHeight: CGFloat {
        return UIWindow.keySafeAreaTop + navigationBarHeight
    }
    
    static var bottomHeight: CGFloat {
        return UIWindow.keySafeAreaBottom
    }
    
    static var fullFrame: CGRect {
        return UIScreen.main.bounds
    }
    
    static var safeAreaViewFrame: CGRect {
        return CGRect(x: 0,
                      y: 0,
                      width: self.width,
                      height: self.height - self.topHeight - self.bottomHeight)
    }
    
    static var tableViewFrame: CGRect {
        var aFrame = self.safeAreaViewFrame
        aFrame.size.height = self.height - self.topHeight
        return aFrame
    }
}
