//
//  BackgroundView.swift
//  LoveCalendar
//
//  Created by kerik on 12.04.2024.
//

import UIKit

class BackgroundView: UIView {
    private var backgroundImage: UIImage

    private lazy var background: UIImageView = {
        let image = UIImageView(image: backgroundImage)
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear

        return image
    }()

    init(frame: CGRect, image: UIImage) {
        self.backgroundImage = image
        super.init(frame: frame)
        addSubview(background)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
