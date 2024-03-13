//
//  NetworkingService.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import Foundation

fileprivate enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkingProtocol {
    func sendRequest<T: Decodable>(from url: URL, decdoingType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func cancel()
}

final class NetworkService: NetworkingProtocol {
    private var currentTask: URLSessionTask?
    
    func cancel() {
        currentTask?.cancel()
    }
    
    func sendRequest<T>(from url: URL, decdoingType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        let urlRequest = getlRequest(url: url, method: .get)
        currentTask = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            guard let data = data, error == nil else { return  }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode(T.self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }
        currentTask?.resume()
    }
    
    private func getlRequest(url: URL, method: HTTPMethod) -> URLRequest{
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
