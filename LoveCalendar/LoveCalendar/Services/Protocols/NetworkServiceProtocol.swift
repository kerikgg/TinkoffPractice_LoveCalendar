//
//  NetworkService.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchRandomActivity(completion: @escaping (Result<ActivityResponseModel, Error>) -> Void)
    func fetchImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}
