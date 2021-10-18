//
//  SerieDetailsCoordinator.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit
import Combine

class SerieDetailsCoordinator: BaseCoordinator {
    
    private let viewModel: SerieDetailsViewModel
    private var bindings = Set<AnyCancellable>()

    init(viewModel: SerieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let serieDetailsViewController = storyBoard.instantiateViewController(ofType: SerieDetailsViewController.self)
        serieDetailsViewController.viewModel = viewModel
        navigationController?.pushViewController(serieDetailsViewController, animated: true)
        
        viewModel.didTapOnBack
            .sink { [weak self] in
                self?.back()
            }
            .store(in: &bindings)
    }
    
    private func back() {
        parentCoordinator?.didFinish(coordinator: self)
        navigationController?.popViewController(animated: true)
    }
}
