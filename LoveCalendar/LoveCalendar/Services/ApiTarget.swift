//
//  ApiTarget.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import Foundation
import Moya

enum ApiTarget: TargetType {
    case getRandomActivity
    case downloadImage(urlString: String)
}

extension ApiTarget {
    var baseURL: URL {
        switch self {
        case .getRandomActivity:
            guard let url = URL(string: "http://localhost:5145")
            else {
                fatalError("ApiTarget url error")
            }
            return url
        case .downloadImage(let urlString):
            guard let url = URL(string: urlString)
            else {
                fatalError("ApiTarget url error")
            }
            return url
        }
    }

    var path: String {
        switch self {
        case .getRandomActivity:
            return "/activities/randomactivity"
        case .downloadImage:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRandomActivity, .downloadImage:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getRandomActivity, .downloadImage:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
