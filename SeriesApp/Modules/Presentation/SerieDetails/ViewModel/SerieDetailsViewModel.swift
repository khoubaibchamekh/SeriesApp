//
//  SerieDetailsViewModel.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Combine

class SerieDetailsViewModel {
    
    var didTapOnBack = PassthroughSubject<Void, Never>()
    let currentSerie: Serie
    @Published var seriePitch = ""
    private let serieRepository: SerieRepository
 
    init(serie: Serie, serieRepository: SerieRepository) {
        currentSerie = serie
        self.serieRepository = serieRepository
        getPitch(for: serie)
    }
    
    func getPitch(for serie: Serie) {
        serieRepository.getPitchForSerie(using: serie.detailLink) { [weak self] result in
            switch result {
            case .success(let pitch):
                self?.seriePitch = pitch
                debugPrint("Received data: ", pitch)

            default:
                break
            }
        }
    }
}
