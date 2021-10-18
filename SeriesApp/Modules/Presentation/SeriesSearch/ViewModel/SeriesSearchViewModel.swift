//
//  SeriesSearchViewModel.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Combine

enum SeriesSearchState {
    case loading
    case finishedLoading
    case error(Error)
}

enum Section {
    case series
}

class SeriesSearchViewModel {
    
    var didTapOnSerie = PassthroughSubject<Serie, Never>()
    @Published var searchText = ""
    @Published private(set) var series: [Serie] = []
    @Published private(set) var state: SeriesSearchState = .finishedLoading
    private let serieRepository: SerieRepository
    private var bindings = Set<AnyCancellable>()

    init(serieRepository: SerieRepository) {
        self.serieRepository = serieRepository
        $searchText
            .sink { [weak self] in
                $0.isEmpty ? self?.series = [] : self?.fetchSeries(with: $0)
            }
            .store(in: &bindings)
    }
    
    func fetchSeries(with searchTerm: String) {
        state = .loading
        serieRepository.getSeries(with: searchTerm) { [weak self] result in
            switch result {
            case .success(let series):
                self?.series = series
                self?.state = .finishedLoading
                
            case.failure(let error):
                self?.state = .error(error)
            }
        }
    }
}
