//
//  AddWishViewController.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

enum AddWishStates {
    case save, back
}

final class AddWishViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((AddWishStates) -> Void)?
    private let addWishView: AddWishView
    private let viewModel: AddWishViewModel

    init(viewModel: AddWishViewModel) {
        self.viewModel = viewModel
        self.addWishView = AddWishView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addWishView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addWishView.delegate = self
        self.navigationItem.title = Strings.Labels.addWishLabel
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.completionHandler?(.back)
        }
    }
}

extension AddWishViewController: AddWishViewDelegate {
    func didTapSave(title: String, url: String?) {
        self.viewModel.addNewWish(title: title, url: url)
        self.completionHandler?(.save)
    }
}
