//
//  CoordinatorProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    var flowCompletionHandler: (() -> Void)? {get set}

    func start()
}
