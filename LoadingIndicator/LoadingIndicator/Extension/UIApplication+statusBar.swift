//
//  UIApplication+statusBar.swift
//  GooDic
//
//  Created by ttvu on 6/10/20.
//  Copyright © 2020 paxcreation. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat {
        let height: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }
        
        return height
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
