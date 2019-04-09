//
//  DrawerViewController.swift
//  DrawerDemo
//
//  Created by Yiyin Shen on 9/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

enum DrawerPosition: Int {
    case left
    case right
}

class DrawerContainerViewController: UIViewController {
    private var mainContainerView: UIView!
    private var drawerContainerView: UIView!
    private var drawerWidth: CGFloat! = 200 {
        didSet {
            updateDrawerContainerFrame()
        }
    }
    private var drawerPosition: DrawerPosition = .left

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGesture()
    }
    
    func configureContainer(with mainViewController: UIViewController, drawerViewController: UIViewController, drawerViewWidth: CGFloat? = 200, position: DrawerPosition) {
        mainViewController.view.frame = mainContainerView.bounds
        mainContainerView.addSubview(mainViewController.view)
        addChild(mainViewController)
        
        drawerViewController.view.frame = drawerContainerView.bounds
        drawerContainerView.addSubview(drawerViewController.view)
        addChild(drawerViewController)
        
        drawerPosition = position
        drawerWidth = drawerViewWidth
    }
    
    private func updateDrawerContainerFrame() {
        drawerContainerView.frame.size.width = drawerWidth
        switch drawerPosition {
        case .left:
            drawerContainerView.frame.origin.x = -drawerWidth
        case .right:
            drawerContainerView.frame.origin.x = view.bounds.width
        }

    }

    private func configureViews() {
        drawerContainerView = UIView(frame: view.bounds)
        updateDrawerContainerFrame()
        view.addSubview(drawerContainerView)

        mainContainerView = UIView(frame: view.bounds)
        view.addSubview(mainContainerView)
    }

    private func configureGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(pan:)))
        mainContainerView.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func didPan(pan: UIPanGestureRecognizer) {
        let offsetPoint = pan.translation(in: mainContainerView)
        if offsetPoint.x > 0 {
            switch self.drawerPosition {
            case .left:
                 openDrawer()
            case .right:
                closeDrawer()
            }
        } else {
            switch self.drawerPosition {
            case .left:
                closeDrawer()
            case .right:
                openDrawer()
            }
        }
    }
    
    private func openDrawer() {
        UIView.animate(withDuration: 0.3) {
            switch self.drawerPosition {
            case .left:
                self.mainContainerView.frame.origin.x = self.drawerWidth
                self.drawerContainerView.frame.origin.x = 0
            case .right:
                self.mainContainerView.frame.origin.x = -self.drawerWidth
                self.drawerContainerView.frame.origin.x = self.view.bounds.width - self.drawerWidth
            }
        }
    }
    
    private func closeDrawer() {
        UIView.animate(withDuration: 0.3) {
            switch self.drawerPosition {
            case .left:
                self.mainContainerView.frame = self.view.bounds
                self.drawerContainerView.frame.origin.x = -self.drawerWidth
            case .right:
                self.mainContainerView.frame = self.view.bounds
                self.drawerContainerView.frame.origin.x = self.view.bounds.width
            }
        }
    }

    @objc
    private func didTap() {
        closeDrawer()
    }
}
