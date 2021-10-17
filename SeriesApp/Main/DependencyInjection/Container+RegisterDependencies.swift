//
//  Container+RegisterDependencies.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Swinject

extension Container {

    func registerDependencies() {
        registerServices()
        registerViewModels()
        registerCoordinators()
    }
}
