//
//  BackgroundView.swift
//  LoveCalendar
//
//  Created by kerik on 12.04.2024.
//

import UIKit

class BackgroundView: UIView {
    private lazy var background: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(background)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
