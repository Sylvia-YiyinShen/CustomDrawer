//
//  ViewController.swift
//  DrawerDemo
//
//  Created by Yiyin Shen on 9/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class MyContainerViewController: DrawerContainerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllersAndConfigureContainer()
    }

    private func createViewControllersAndConfigureContainer() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
        let drawerViewController = mainStoryboard.instantiateViewController(withIdentifier: "DrawerViewController")
        
        configureContainer(with: mainViewController, drawerViewController: drawerViewController, drawerViewWidth: 200, position: .right)
    }
}

