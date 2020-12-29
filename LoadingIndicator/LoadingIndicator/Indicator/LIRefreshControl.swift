//
//  LIRefreshControl.swift
//  LoadingIndicator
//
//  Created by Yoyo on 12/28/20.
//

import UIKit

class LIRefreshControl: UIRefreshControl {
    
    struct Constant {
        static let height: CGFloat = 44.0
    }
    
    fileprivate var refreshContainerView: Indicator!
    fileprivate var canPullToRefresh: Bool = true
    fileprivate var isPulling: Bool = true
    
    override init() {
        super.init()
        
        // to make the default indicator be visible
        self.tintColor = .clear
        self.subviews.first?.alpha = 0
        
        setupRefreshControl()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRefreshControl() {
        refreshContainerView = Indicator(frame: CGRect(x: 0, y: 0, width: Constant.height, height: Constant.height))
        
        addSubview(self.refreshContainerView)
        
        refreshContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            refreshContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            refreshContainerView.widthAnchor.constraint(equalToConstant: Constant.height),
            refreshContainerView.heightAnchor.constraint(equalToConstant: Constant.height)
        ])
    }
    
    func pull(to value: CGFloat) {
        if value == 0 && canPullToRefresh {
            isPulling = true
        }
        
        if self.isRefreshing == false && isPulling {
            let percent = value < 0 ? 0 : value / Constant.height
            refreshContainerView.pull(to: percent)
        }
    }
    
    func releasePull() {
        canPullToRefresh = true
    }
    
    override func beginRefreshing() {
        refreshContainerView.startAnim()
        super.beginRefreshing()
        isPulling = false
        canPullToRefresh = false
    }
    
    override func endRefreshing() {
        refreshContainerView.stopAnim()
        super.endRefreshing()
    }
}

