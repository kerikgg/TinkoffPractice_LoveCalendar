//
//  AddEventViewController.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import UIKit

enum AddEventStates {
    case save, back
}

final class AddEventViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((AddEventStates) -> Void)?
    private let addEventView: AddEventView
    private let viewModel: AddEventViewModel
    private var pickedImage: UIImage?
    private var alertFactory = AlertFactory()

    init(viewModel: AddEventViewModel) {
        self.viewModel = viewModel
        self.addEventView = AddEventView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addEventView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addEventView.delegate = self
        self.addEventView.configureDateLabel(with: viewModel.getPickedDate())
        view.backgroundColor = .white
        self.navigationItem.title = Strings.Titles.newEvent
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.completionHandler?(.back)
        }
    }
}

extension AddEventViewController: AddEventViewDelegate {
    func didTapSave(title: String) {
        if let pickedImage {
            guard let imageData = pickedImage.jpegData(compressionQuality: 0.15) else { return }
            let event = EventModel(uid: UUID(), title: title, date: viewModel.getPickedDate(), image: imageData)
            viewModel.addNewEvent(event: event)
            self.completionHandler?(.save)
        } else {
            let alert = alertFactory.makeErrorAlert(message: Strings.Alerts.Messages.photo)
            present(alert, animated: true)
        }
    }

    func didTapChangeAvatar() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension AddEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.addEventView.configureImage(editedImage)
            pickedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.addEventView.configureImage(originalImage)
            pickedImage = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
