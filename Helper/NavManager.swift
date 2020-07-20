//
//  NavManager.swift
//  MapController
//
//  Created by Lloyd Fung on 7/6/2018.
//  Copyright © 2018年 Centaline Property. All rights reserved.
//

// https://docs.google.com/document/d/1-6g0J8F-ClhZBW1XNvcdhmu3Ue2Yoo5Zjp4hEGso3lA/edit

import AVKit
import Foundation

class NavManager: NSObject {
    
    static func getRootNav() -> UINavigationController? {
        guard let rootNav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            return nil
        }
        return rootNav
    }
    
    static func getTopMostVC() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    static func getCurrentViewController() -> UIViewController? {
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        return findBestViewController(vc: viewController!)
    }
    
    static func checkIsTopVC(viewController: UIViewController?) -> Bool {
        var isTopVC = false
        if (viewController == nil) {
            // isTopVC = false
        } else {
            isTopVC = (viewController == self.getCurrentViewController())
        }
        return isTopVC
    }
    
    // Popback to view by backCount number
    static func popToViewControllers(backCount: Int, animated: Bool) {
        guard backCount > 0 else { return }
        let veiwControllers = NavManager.getRootNav()?.viewControllers
        let viewControllersCount = (veiwControllers?.count ?? 0)
        var finalIndex = viewControllersCount - (backCount + 1)
        finalIndex = (finalIndex >= 0) ? finalIndex : 0 // 如果係負數，變翻做0
        if let targetViewController = veiwControllers?[finalIndex] {
            NavManager.getRootNav()?.popToViewController(targetViewController, animated: animated)
        }
    }
    
    // Popback to view by class
    static func popToFirstViewControllerFromClass<T>(classType: T.Type, extraPop: Bool = false, animated: Bool) {
        guard let viewControllers = NavManager.getRootNav()?.viewControllers else { return }
        
        var popupCount = 0
        
        for (i, viewController) in viewControllers.enumerated() {
            if classType == viewController.classForCoder && popupCount == 0 {
                // Found target class Type, and just get index with i
                popupCount = i + 1
            }
        }
        
        if(popupCount != 0) {
            // Pop to target ViewController
            let extraPopInt = extraPop ? 1 : 0
            let totalBackCount = viewControllers.count - (popupCount - extraPopInt)
            print("NavManager popToFirstViewControllerFromClass - Count : \(viewControllers.count), TotalBackCount: \(totalBackCount)")
            self.popToViewControllers(backCount: totalBackCount, animated: animated)
        }
    }
    
    static func findBestViewController(vc : UIViewController) -> UIViewController {
        
        if vc.presentedViewController != nil {
            return NavManager.findBestViewController(vc: vc.presentedViewController!)
        } else if vc.isKind(of:UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return NavManager.findBestViewController(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let nvc = vc as! UINavigationController
            if nvc.viewControllers.count > 0 {
                return NavManager.findBestViewController(vc: nvc.topViewController!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let tvc = vc as! UITabBarController
            if (tvc.viewControllers?.count)! > 0 {
                return NavManager.findBestViewController(vc: tvc.selectedViewController!)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
    
    static func present(vc: UIViewController, animate: Bool, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = .fullScreen
        getRootNav()?.present(vc, animated: animate, completion: completion)
    }
}
