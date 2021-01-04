//
//  LILoadingViewController.swift
//  LoadingIndicator
//
//  Created by Yoyo on 12/29/20.
//

import UIKit

class LILoadingViewController: UIViewController {
    
    struct Constant {
        static let large: CGFloat = 92
    }
    
    static let shared = LILoadingViewController()
    
    // MARK: - UI
    lazy var centerActivityIndicator: LIActivityIndicatorView = {
        let control = LIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: Constant.large, height: Constant.large))
        return control
    }()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(33.0 / 255.0)
        
        self.view.addSubview(centerActivityIndicator)
        centerActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerActivityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.centerActivityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.centerActivityIndicator.widthAnchor.constraint(equalToConstant: self.centerActivityIndicator.bounds.width),
            self.centerActivityIndicator.heightAnchor.constraint(equalToConstant: self.centerActivityIndicator.bounds.height)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        centerActivityIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        centerActivityIndicator.stopAnimating()
    }
    
    // MARK: - funcs
    // MARK: - funcs
    func show() {
        if let window = UIWindow.key {
            window.addSubview(self.view)
            
            self.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                window.topAnchor.constraint(equalTo: self.view.topAnchor),
                window.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                window.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                window.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
    }
    
    func hide() {
        self.dismiss(animated: true, completion: nil)
    }
}
