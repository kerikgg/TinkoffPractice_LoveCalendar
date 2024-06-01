//
//  EditProfileViewController.swift
//  LoveCalendar
//
//  Created by kerik on 24.05.2024.
//

import UIKit
import Combine

enum EditProfileState {
    case save, back
}

final class EditProfileViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((EditProfileState) -> Void)?
    private let editProfileView = EditProfileView(frame: .zero)
    private let viewModel: EditProfileViewModel
    private var pickedUserImage: UIImage?
    var cancellables = Set<AnyCancellable>()

    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.getUserData()
        getCurrentUserImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = editProfileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
        getCurrentUserImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView.delegate = self
        setupNavigationBar()
        setBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            completionHandler?(.back)
        }
    }
}

extension EditProfileViewController: EditProfileViewDelegate {
    func didTapSave() {
        self.viewModel.updateData(
            imageData: self.pickedUserImage?.jpegData(compressionQuality: 0.15),
            name: self.editProfileView.getNameTextField())
        self.completionHandler?(.save)
    }
    
    func didTapChangeAvatar() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.editProfileView.setUserImage(editedImage)
            pickedUserImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.editProfileView.setUserImage(originalImage)
            pickedUserImage = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController {
    private func setBindings() {
        viewModel.$userModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }
                self.editProfileView.configureProfile(with: user)
            }
            .store(in: &cancellables)
    }
}

extension EditProfileViewController {
    private func setupNavigationBar() {
        navigationItem.title = Strings.Titles.editProfile
    }
}

extension EditProfileViewController {
    private func getCurrentUserImage() {
        if let userModel = viewModel.getUserModel() {
            guard let imageData = userModel.avatarData else {
                return
            }
            pickedUserImage = UIImage(data: imageData)
        }
    }
}
