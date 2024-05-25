//
//  RouterProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import UIKit

protocol RouterProtocol {
    func present(_ controller: UIViewController, animated: Bool)

    func push(_ controller: UIViewController, animated: Bool)
    func push(_ controller: UIViewController, animated: Bool, hideBottomBar: Bool)

    func pop(animated: Bool)
    func popToRootController(animated: Bool)

    func dismiss(animated: Bool)

    func setViewController(_ controller: UIViewController, isNavigationBarHidden: Bool)
    func setViewController(_ controller: UIViewController)

    func showRootController() -> UINavigationController?
}
