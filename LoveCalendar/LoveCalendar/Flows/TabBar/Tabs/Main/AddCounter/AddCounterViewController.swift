//
//  AddCounterViewController.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import UIKit

enum AddCounterStates {
    case save, back
}

final class AddCounterViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((AddCounterStates) -> Void)?
    private let addCounterView: AddCounterView
    private let viewModel: AddCounterViewModel
    private var alertFactory = AlertFactory()
    private var pickedImage: UIImage?

    init(viewModel: AddCounterViewModel) {
        self.viewModel = viewModel
        self.addCounterView = AddCounterView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addCounterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCounterView.delegate = self
        self.navigationItem.title = "Новый счетчик"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.completionHandler?(.back)
        }
    }
}

extension AddCounterViewController: AddCounterViewDelegate {
    func didTapSave(partnerName: String?, date: Date) {
        guard let partnerName = partnerName, !partnerName.isEmpty else {
            let alert = alertFactory.makeErrorAlert(message: "Partner name cannot be empty.")
            present(alert, animated: true)
            return
        }

        if let pickedImage {
            guard let imageData = pickedImage.jpegData(compressionQuality: 0.15) else { return }
            let counter = CounterModel(uid: UUID(), partnerName: partnerName, image: imageData, startDate: date)
            viewModel.addNewCounter(counter: counter)
            self.completionHandler?(.save)
        } else {
            let alert = alertFactory.makeErrorAlert(message: Strings.Alerts.Messages.photo)
            present(alert, animated: true)
        }
    }

    func didTapChoosePhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension AddCounterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.addCounterView.configureImage(editedImage)
            pickedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.addCounterView.configureImage(originalImage)
            pickedImage = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
