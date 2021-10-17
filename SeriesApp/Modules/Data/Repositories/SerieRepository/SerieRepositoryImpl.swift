//
//  SerieRepositoryImpl.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import Foundation
 
final class SerieRepositoryImpl: SerieRepository {
    
    private let httpClient: HttpClient
    private let seriesEndpoint = "https://api.ocs.fr/apps/v2/contents?search=title%3D"

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getSeries(with title: String, completion: @escaping (Result<[Serie], Error>) -> Void) {
        guard let url = URL(string: seriesEndpoint + title) else {
            completion(.failure(ApiError.requestFailed(error: "Invalid URL")))
            return
        }
        
        let apiRequest = ApiRequest(resource: url)
        httpClient.request(apiRequest) { result in
            switch result {
            case .success(let json):
                var serieList: [Serie] = []
                if let series = json["contents"] as? [[String: Any]] {
                    serieList = series.map { serie in
                        return Serie(
                            title: ((serie["title"] as? [[String: Any]])?[0])?["value"] as? String ?? "",
                            subtitle: serie["subtitle"] as? String ?? "",
                            previewImageURL: serie["imageurl"] as? String ?? "",
                            largeImageURL: serie["fullscreenimageurl"] as? String ?? "",
                            detailLink: serie["detaillink"] as? String ?? ""
                        )
                    }
                }
                
                completion(.success(serieList))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
