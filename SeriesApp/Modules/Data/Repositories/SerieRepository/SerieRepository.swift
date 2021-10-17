//
//  SerieRepository.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

protocol SerieRepository {
    func getSeries(with title: String, completion: @escaping (Result<[Serie], Error>) -> Void)
}
