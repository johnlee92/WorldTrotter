//
//  AppDelegate.swift
//  WorldTrotter
//
//  Created by 이재현 on 2019/10/17.
//  Copyright © 2019 Jaehyeon Lee. All rights reserved.
//

import UIKit

import Then
import CGFloatLiteral
import SnapKit
import RxGesture
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    
    let conversionViewController = ConversionViewController(
      reactor: ConversionViewReactor(measureService: MeasureService())
    )
    
    let mapViewController = UIViewController()
    mapViewController.view = MKMapView()
    mapViewController.tabBarItem = .init(title: "Map", image: #imageLiteral(resourceName: "MapIcon"), tag: 1)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [
      conversionViewController,
      mapViewController
    ]

    window.rootViewController = tabBarController
    
    self.window = window
    return true
  }
}

