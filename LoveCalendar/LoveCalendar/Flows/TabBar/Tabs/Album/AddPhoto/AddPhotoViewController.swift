//
//  AddPhotoViewController.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import UIKit

enum AddPhotoStates {
    case save, back
}

final class AddPhotoViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((AddPhotoStates) -> Void)?
    private let addPhotoView: AddPhotoView
    private let viewModel: AddPhotoViewModel
    private var pickedImage: UIImage?
    private var alertFactory = AlertFactory()

    init(viewModel: AddPhotoViewModel) {
        self.viewModel = viewModel
        self.addPhotoView = AddPhotoView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addPhotoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPhotoView.delegate = self
        self.navigationItem.title = Strings.Titles.newPhoto
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.completionHandler?(.back)
        }
    }
}

extension AddPhotoViewController: AddPhotoViewDelegate {
    func didTapSave(title: String) {
        if let pickedImage {
            guard let imageData = pickedImage.jpegData(compressionQuality: 0.15) else { return }
            let photo = PhotoModel(uid: UUID(), title: title, image: imageData)
            viewModel.addNewPhoto(photo: photo)
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

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.addPhotoView.configureImage(editedImage)
            pickedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.addPhotoView.configureImage(originalImage)
            pickedImage = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
