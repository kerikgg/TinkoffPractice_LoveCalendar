//
//  MainView.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//
import UIKit

protocol MainViewDelegate: AnyObject {
    func didTapDaysSinceLabel()
}

final class MainView: UIView {
    private let backgroundView = BackgroundView(frame: .zero, image: UIImage.mainScreenBackground)
    private let startView = StartView(frame: .zero)
    weak var delegate: MainViewDelegate?
    var areAdditionalLabelsVisible = false

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.labelText.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true

        return imageView
    }()

    private lazy var namesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .labelText
        label.isHidden = true

        return label
    }()

    private lazy var daysSinceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .left
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleAdditionalLabels))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        label.isHidden = true

        return label
    }()

    private let weeksSinceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.alpha = 0.0
        return label
    }()

    private let monthsSinceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.alpha = 0.0
        return label
    }()

    private let yearsSinceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.alpha = 0.0
        return label
    }()

    private lazy var daysUntilAnniversaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.isHidden = true

        return label
    }()

    private lazy var daysStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                daysSinceLabel, weeksSinceLabel, monthsSinceLabel, yearsSinceLabel, daysUntilAnniversaryLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(backgroundView, imageView, namesLabel, daysStackView, startView)
        weeksSinceLabel.isHidden = true
        monthsSinceLabel.isHidden = true
        yearsSinceLabel.isHidden = true

        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    @objc func toggleAdditionalLabels() {
        areAdditionalLabelsVisible.toggle()
        updateAdditionalLabelsVisibility()
    }

    private func updateAdditionalLabelsVisibility() {
        let alpha: CGFloat = areAdditionalLabelsVisible ? 1.0 : 0.0
        let isVisible = areAdditionalLabelsVisible

        weeksSinceLabel.isHidden = !isVisible
        monthsSinceLabel.isHidden = !isVisible
        yearsSinceLabel.isHidden = !isVisible

        UIView.animate(withDuration: 0.3) {
            self.weeksSinceLabel.alpha = alpha
            self.monthsSinceLabel.alpha = alpha
            self.yearsSinceLabel.alpha = alpha
            self.layoutIfNeeded()
        }
    }
}

extension MainView {
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        startView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250, height: 250))
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
        }

        namesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp_bottomMargin).offset(50)
        }

        daysStackView.snp.makeConstraints { make in
            make.top.equalTo(namesLabel.snp_bottomMargin).offset(50)
            make.leading.equalToSuperview().inset(20)
        }
    }
}

extension MainView {
    func displayStartView(flag: Bool) {
        startView.isHidden = flag
        imageView.isHidden = !flag
        namesLabel.isHidden = !flag
        daysSinceLabel.isHidden = !flag
        daysUntilAnniversaryLabel.isHidden = !flag
    }

    func setDelegate(controller: UIViewController) {
        startView.delegate = controller as? any StartViewDelegate
    }

    func updateDaysSinceLabel(with text: String) {
        daysSinceLabel.text = text
    }

    func updateWeeksSinceLabel(with text: String) {
        weeksSinceLabel.text = text
    }

    func updateMonthsSinceLabel(with text: String) {
        monthsSinceLabel.text = text
    }

    func updateYearsSinceLabel(with text: String) {
        yearsSinceLabel.text = text
    }

    func updateDaysUntilAnniversaryLabel(with text: String) {
        daysUntilAnniversaryLabel.text = text
    }
}

extension MainView {
    func configureView(names: String, imageData: Data) {
        namesLabel.text = names
        imageView.image = UIImage(data: imageData)
    }
}
