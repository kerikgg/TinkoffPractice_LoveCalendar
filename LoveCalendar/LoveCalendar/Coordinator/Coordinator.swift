//
//  Coordinator.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class Coordinator: CoordinatorProtocol {
    var flowCompletionHandler: ((FlowCompletionState?) -> Void)?
    var childCoordinators: [CoordinatorProtocol]
    let coordinatorFactory: CoordinatorFactoryProtocol
    let moduleFactory: ModuleFactory

    init() {
        childCoordinators = []
        coordinatorFactory = CoordinatorFactory()
        moduleFactory = ModuleFactory()
    }

    func start() {
        fatalError("func must be overriden")
    }

    func addCoordinatorDependency(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    func deleteCoordinatorDependency(_ coordinator: CoordinatorProtocol?) {
        guard !childCoordinators.isEmpty else { return }

        // Clear child coordinators recursively
        if let coordinator = coordinator as? Coordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.deleteCoordinatorDependency($0) })
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
