//
//  UIViewExtensions.swift
//  LoveCalendar
//
//  Created by kerik on 12.04.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
