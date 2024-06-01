//
//  NetworkService.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import Foundation
import Moya

final class NetworkService: NetworkServiceProtocol {
    private var provider: MoyaProvider<ApiTarget>
    private var jsonDecoder: JSONDecoder

    static let shared = NetworkService()
    private init() {
        provider = MoyaProvider<ApiTarget>()
        jsonDecoder = JSONDecoder()
    }

    func fetchRandomActivity(completion: @escaping (Result<ActivityResponseModel, any Error>) -> Void) {
        request(target: .getRandomActivity, completion: completion)
    }

    func fetchImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        provider.request(.downloadImage(urlString: urlString)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension NetworkService {
    func request<T: Decodable>(target: ApiTarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    print("Data decode error")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
