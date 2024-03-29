//
//  FlowControllerWithValue.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol FlowControllerWithValue: AnyObject {
    associatedtype Value
    var completionHandler: ((Value) -> Void)? {get set}
}
