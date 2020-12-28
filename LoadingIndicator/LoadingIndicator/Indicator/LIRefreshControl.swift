//
//  LIRefreshControl.swift
//  LoadingIndicator
//
//  Created by Yoyo on 12/28/20.
//

import UIKit

class LIRefreshControl: UIRefreshControl {
    fileprivate var refreshContainerView: Indicator!
    
    required override init(frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)) {
        super.init()
        
        bounds.size.width = frame.size.width
        setupRefreshControl()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRefreshControl() {
        refreshContainerView = Indicator(frame: self.bounds)
        
        addSubview(self.refreshContainerView)
    }
    
    override func beginRefreshing() {
        refreshContainerView.startAnim()
        print("begin")
    }
    
    override func endRefreshing() {
        refreshContainerView.endAnim()
        super.endRefreshing()
    }
}

