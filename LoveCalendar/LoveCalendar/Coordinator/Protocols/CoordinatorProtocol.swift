//
//  CoordinatorProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

enum FlowCompletionState {
    case next, back
}

protocol CoordinatorProtocol: AnyObject {
    var flowCompletionHandler: ((FlowCompletionState?) -> Void)? {get set}

    func start()
}
