//
//  ViewController.swift
//  LoadingIndicator
//
//  Created by Yoyo on 12/28/20.
//

import UIKit

class ViewController: UITableViewController {

    struct Constant {
        static let medium = 60
        static let small = 30
    }
    
    // MARK: - UI
    lazy var myRefreshControl: LIRefreshControl = {
        let control = LIRefreshControl()
        control.addTarget(self, action: #selector(endRefresh(sender:)), for: .valueChanged)
        return control
    }()
    
    lazy var centerActivityIndicator: LIActivityIndicatorView = {
        let control = LIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: Constant.medium, height: Constant.medium))
        return control
    }()
    
    lazy var footer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        view.addSubview(bottomActivityIndicator)
        
        bottomActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.bottomActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.bottomActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.bottomActivityIndicator.widthAnchor.constraint(equalToConstant: self.bottomActivityIndicator.bounds.width),
            self.bottomActivityIndicator.heightAnchor.constraint(equalToConstant: self.bottomActivityIndicator.bounds.height)
        ])
        
        return view
    }()
    
    lazy var bottomActivityIndicator: LIActivityIndicatorView = {
        let control = LIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: Constant.small, height: Constant.small))
//        control.color = Asset.textSecondary.color
        
        NSLayoutConstraint.activate([
            control.heightAnchor.constraint(equalToConstant: control.bounds.height),
            control.widthAnchor.constraint(equalToConstant: control.bounds.width)
        ])
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }

    func setupUI() {
        super.loadView()
        
        tableView.refreshControl = myRefreshControl
        
        self.view.addSubview(centerActivityIndicator)
        centerActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerActivityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.centerActivityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.centerActivityIndicator.widthAnchor.constraint(equalToConstant: self.centerActivityIndicator.bounds.width),
            self.centerActivityIndicator.heightAnchor.constraint(equalToConstant: self.centerActivityIndicator.bounds.height)
        ])
    }
    
    @objc func endRefresh(sender:Any) {
        myRefreshControl.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.myRefreshControl.endRefreshing()
        }
    }
    
    private func showCenterIndicator() {
        centerActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.centerActivityIndicator.stopAnimating()
        }
    }
    
    private func showLoadMore() {
        if bottomActivityIndicator.isAnimating == false {
            tableView.tableFooterView = footer
            bottomActivityIndicator.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: 1)))
                self.bottomActivityIndicator.stopAnimating()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = -(scrollView.contentOffset.y + scrollView.adjustedContentInset.top)
        myRefreshControl.pull(to: value)
        
        if scrollView.isNearBottomEdge() {
            showLoadMore()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        myRefreshControl.releasePull()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCenterIndicator()
    }
}

