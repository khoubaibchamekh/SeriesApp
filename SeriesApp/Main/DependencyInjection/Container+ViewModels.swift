//
//  Container+ViewModels.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Swinject
import SwinjectAutoregistration

extension Container {

    func registerViewModels() {
        autoregister(SeriesSearchViewModel.self, initializer: SeriesSearchViewModel.init)
        register(SerieDetailsViewModel.self) { (resolver, serie) -> SerieDetailsViewModel in
            return SerieDetailsViewModel(serie: serie, serieRepository: resolver.resolve(SerieRepository.self)!)
        }
    }
}
