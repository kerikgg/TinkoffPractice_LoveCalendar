//
//  UIViewControllerExtensions.swift
//  LoveCalendar
//
//  Created by kerik on 09.04.2024.
//

import UIKit

extension UIViewController {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
}
