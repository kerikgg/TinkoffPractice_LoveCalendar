//
//  AlertFactory.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

final class AlertFactory {
    func makeLogOutAlert(logOutAction: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alert = UIAlertController(
            title: Strings.Alerts.Titles.logOut,
            message: Strings.Alerts.Messages.logOut,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.Alerts.Actions.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: Strings.Alerts.Actions.logOut, style: .destructive, handler: logOutAction))

        return alert
    }

    func makeErrorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(
            title: Strings.Alerts.Titles.error,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))

        return alert
    }

    func makeDeleteCounterAlert(action: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alert = UIAlertController(
            title: Strings.Alerts.Titles.deleteCounter,
            message: Strings.Alerts.Messages.deleteCounter,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.Alerts.Actions.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: Strings.Titles.delete, style: .destructive, handler: action))

        return alert
    }
}
