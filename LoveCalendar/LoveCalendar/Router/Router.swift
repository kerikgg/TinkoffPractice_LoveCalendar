//
//  Router.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import UIKit

class Router: RouterProtocol {
    private var rootController: UINavigationController?

    init(rootController: UINavigationController?) {
        self.rootController = rootController
    }

    func present(_ controller: UIViewController, animated: Bool) {
        rootController?.present(controller, animated: animated)
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func push(_ controller: UIViewController, animated: Bool, hideBottomBar: Bool) {
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    func popToRootController(animated: Bool) {
        rootController?.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        rootController?.dismiss(animated: animated)
    }
    
    func setViewController(_ controller: UIViewController, isNavigationBarHidden: Bool) {
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = isNavigationBarHidden
    }
    
    func setViewController(_ controller: UIViewController) {
        rootController?.setViewControllers([controller], animated: false)
    }
    
    func showRootController() -> UINavigationController? {
        return rootController
    }
}
