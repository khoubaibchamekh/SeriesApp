//
//  SeriesSearchCoordinator.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit
import Combine

class SeriesSearchCoordinator: BaseCoordinator {
    
    private let viewModel: SeriesSearchViewModel
    private var bindings = Set<AnyCancellable>()

    init(viewModel: SeriesSearchViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let seriesSearchViewController = storyBoard.instantiateViewController(ofType: SeriesSearchViewController.self)
        seriesSearchViewController.viewModel = viewModel
        navigationController?.viewControllers = [seriesSearchViewController]
        
        viewModel.didTapOnSerie
            .sink { [weak self] serie in
                self?.showSerieDetails(serie: serie)
            }
            .store(in: &bindings)
    }
    
    private func showSerieDetails(serie: Serie) {
        let coordinator = AppDelegate.container.resolve(SerieDetailsCoordinator.self, argument: serie)!
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
