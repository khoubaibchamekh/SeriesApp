//
//  Container+Coordinators.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Swinject
import SwinjectAutoregistration

extension Container {

    func registerCoordinators() {
        register(AppCoordinator.self) { (_, window: UIWindow?, navigation: UINavigationController?) -> AppCoordinator in
            return AppCoordinator(window: window, navigation: navigation)
        }
        
        autoregister(SeriesSearchCoordinator.self, initializer: SeriesSearchCoordinator.init)
    }
}
