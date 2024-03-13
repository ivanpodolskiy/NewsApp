//
//  NetworkError.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//


enum DataError {
    case notitems
}
enum NetworkError: Error {
    case noData
    case badURL
    case notFound
    case serverError
    case decodingError
    case badRequest
    case customError(String)
    case unauthorized
    case forbidden
    case unknown(Int)
    case notConnectedToInternet
    case dataError(DataError)
    case invalidResponse
}
