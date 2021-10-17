//
//  AppCoordinator.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    var window: UIWindow?
    
    init(window: UIWindow?, navigation: UINavigationController?) {
        super.init()
        self.window = window
        self.navigationController = navigation
    }
    
    override func start() {
        let coordinator = AppDelegate.container.resolve(SeriesSearchCoordinator.self)!
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
