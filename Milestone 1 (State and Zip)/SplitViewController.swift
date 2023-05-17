//
//  SplitViewController.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/15/23.
//

import UIKit
class SplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the master and detail view controllers
        let masterViewController = ViewController()
        let detailViewController = FirstViewController()
        
        
        // Embed them in navigation controllers
        let masterNavigationController = UINavigationController(rootViewController: masterViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        //let thirdnvc = UINavigationController(rootViewController: third)
        
        // Set the view controllers for the split view controller
        self.viewControllers = [masterNavigationController, detailNavigationController]
        
        // Set the preferred display mode for the split view controller
        self.preferredDisplayMode = .oneBesideSecondary
    }
}


