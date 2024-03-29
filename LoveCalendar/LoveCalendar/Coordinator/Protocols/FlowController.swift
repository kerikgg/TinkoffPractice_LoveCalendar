//
//  FlowController.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol FlowController: AnyObject {
    var completionHandler: (() -> Void)? {get set}
}
