//
//  ProfileViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import SnapKit
import Combine

enum ProfileStates {
    case logOut, settings
}

class ProfileViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((ProfileStates) -> Void)?
    private let profileView = ProfileView(frame: .zero)
    private let viewModel: ProfileViewModel
    var cancellables = Set<AnyCancellable>()

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.getUserData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        profileView.delegate = self
        navigationItem.title = Strings.Titles.profile

        let leftBarButtonItem = customLeftBarButtonItem()
        let rightBarButtonItem = customRightBarButtonItem()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension ProfileViewController {
    private func customLeftBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            self?.viewModel.logOut()
            self?.completionHandler?(.logOut)
        }

        let button = UIBarButtonItem(image: SystemImages.logOut, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }

    private func customRightBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            self?.completionHandler?(.settings)
        }

        let button = UIBarButtonItem(image: SystemImages.gearShape, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapChangeAvatar() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileView.userImage.image = editedImage
            viewModel.setUserAvatar(imageData: editedImage.jpegData(compressionQuality: 0.15))
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileView.userImage.image = originalImage
            viewModel.setUserAvatar(imageData: originalImage.jpegData(compressionQuality: 0.15))
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// extension ProfileViewController {
//    private func getUserData() {
//        viewModel.getUserData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let userModel):
//                profileView.configureProfile(with: userModel)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
// }

extension ProfileViewController {
    private func setBindings() {
        viewModel.$userModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }
                self.profileView.configureProfile(with: user)
            }
            .store(in: &cancellables)
    }
}
