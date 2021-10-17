//
//  ApiError.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/16/21.
//

import Foundation

enum ApiError: Equatable, Error {
    case dataError
    case nonHTTPResponse
    case serializationError
    case requestFailed(error: String?)
}
