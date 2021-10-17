//
//  Container+Services.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Swinject
import SwinjectAutoregistration

extension Container {

    func registerServices() {
        autoregister(HttpClient.self, initializer: APIClient.init).inObjectScope(.transient)
        autoregister(SerieRepository.self, initializer: SerieRepositoryImpl.init)
    }
}
