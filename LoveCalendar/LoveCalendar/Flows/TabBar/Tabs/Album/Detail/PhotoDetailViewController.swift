//
//  PhotoDetailViewController.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import UIKit

protocol PhotoDetailViewControllerDelegate: AnyObject {
    func didDeletePhoto(_ photo: PhotoModel)
}

class PhotoDetailViewController: UIViewController {
    private let displayableItem: Displayable
    weak var delegate: PhotoDetailViewControllerDelegate?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .black

        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.Buttons.close, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(white: 0, alpha: 0.5)
        button.layer.cornerRadius = 10
        
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(SystemImages.trash, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.isHidden = true

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let photo = displayableItem as? PhotoModel else { return }
            self.delegate?.didDeletePhoto(photo)
            dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    init(displayableItem: Displayable) {
        self.displayableItem = displayableItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews(imageView, closeButton, deleteButton, titleLabel, dateLabel)
        makeConstraints()
        setupUI()
    }
}

extension PhotoDetailViewController {
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }

        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-10)
        }

        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    private func setupUI() {
        imageView.image = UIImage(data: displayableItem.imageData)
        titleLabel.text = displayableItem.displayTitle
        if let event = displayableItem as? EventModel {
            dateLabel.text = event.date.toLocalTimeZoneString()
            deleteButton.isHidden = true
        } else {
            dateLabel.isHidden = true
            deleteButton.isHidden = false
        }
    }
}
