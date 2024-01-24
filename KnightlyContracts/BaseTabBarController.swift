//
//  BaseTabBarController.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-15.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController
{
    var m: DataModelManager?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let count = viewControllers?.count
        {
            for i in 0 ..< count
            {
                if let vc = viewControllers?[i] as? TabViewController
                {
                    vc.m = m
                }
            }
        }
               
        viewControllers!.forEach { $0.view }
        
        // Do any additional setup after loading the view.
    }
}
