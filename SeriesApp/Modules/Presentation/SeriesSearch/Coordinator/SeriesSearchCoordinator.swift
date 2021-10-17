//
//  SeriesSearchCoordinator.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit

class SeriesSearchCoordinator: BaseCoordinator {
    
    private let viewModel: SeriesSearchViewModel
    
    init(viewModel: SeriesSearchViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let seriesSearchViewController = storyBoard.instantiateViewController(ofType: SeriesSearchViewController.self)
        seriesSearchViewController.viewModel = viewModel
        navigationController?.viewControllers = [seriesSearchViewController]
    }
}
