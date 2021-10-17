//
//  HttpClient.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/16/21.
//

protocol HttpClient {
    func request(_ request: ApiRequest, completion: @escaping (Result<[String: Any], Error>) -> Void)
    func request<T>(_ request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
}
