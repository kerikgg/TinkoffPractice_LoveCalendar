// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Alerts {
    public enum Actions {
      /// Cancel
      public static let cancel = Strings.tr("Localizable", "alerts.actions.cancel", fallback: "Cancel")
      /// Logout
      public static let logOut = Strings.tr("Localizable", "alerts.actions.logOut", fallback: "Logout")
    }
    public enum Messages {
      /// Are you sure you want to logout?
      public static let logOut = Strings.tr("Localizable", "alerts.messages.logOut", fallback: "Are you sure you want to logout?")
    }
    public enum Titles {
      /// Error
      public static let error = Strings.tr("Localizable", "alerts.titles.error", fallback: "Error")
      /// Logout
      public static let logOut = Strings.tr("Localizable", "alerts.titles.logOut", fallback: "Logout")
    }
  }
  public enum Buttons {
    /// Change Avatar
    public static let changeAvatar = Strings.tr("Localizable", "buttons.changeAvatar", fallback: "Change Avatar")
    /// Idea for meeting
    public static let ideaForMeeting = Strings.tr("Localizable", "buttons.ideaForMeeting", fallback: "Idea for meeting")
    /// Save
    public static let save = Strings.tr("Localizable", "buttons.save", fallback: "Save")
    /// Localizable.strings
    ///   LoveCalendar
    /// 
    ///   Created by kerik on 16.04.2024.
    public static let signIn = Strings.tr("Localizable", "buttons.signIn", fallback: "Sign In")
    /// Sign Up
    public static let signUp = Strings.tr("Localizable", "buttons.signUp", fallback: "Sign Up")
  }
  public enum Cells {
    /// Dark theme
    public static let darkTheme = Strings.tr("Localizable", "cells.darkTheme", fallback: "Dark theme")
    /// Edit profile
    public static let editProfile = Strings.tr("Localizable", "cells.editProfile", fallback: "Edit profile")
  }
  public enum Labels {
    /// Sign In
    public static let signInLabel = Strings.tr("Localizable", "labels.signInLabel", fallback: "Sign In")
    /// Registration
    public static let signUpLabel = Strings.tr("Localizable", "labels.signUpLabel", fallback: "Registration")
  }
  public enum Sections {
    /// Appearance
    public static let appearance = Strings.tr("Localizable", "sections.appearance", fallback: "Appearance")
    /// Profile
    public static let profile = Strings.tr("Localizable", "sections.profile", fallback: "Profile")
  }
  public enum TextFields {
    /// Email
    public static let emailPlaceholder = Strings.tr("Localizable", "textFields.emailPlaceholder", fallback: "Email")
    /// Name
    public static let namePlaceholder = Strings.tr("Localizable", "textFields.namePlaceholder", fallback: "Name")
    /// Password confirmation
    public static let passwordConfirmationPlaceholder = Strings.tr("Localizable", "textFields.passwordConfirmationPlaceholder", fallback: "Password confirmation")
    /// Password
    public static let passwordPlaceholder = Strings.tr("Localizable", "textFields.passwordPlaceholder", fallback: "Password")
  }
  public enum Titles {
    /// Album
    public static let album = Strings.tr("Localizable", "titles.album", fallback: "Album")
    /// Calendar
    public static let calendar = Strings.tr("Localizable", "titles.calendar", fallback: "Calendar")
    /// Edit profile
    public static let editProfile = Strings.tr("Localizable", "titles.editProfile", fallback: "Edit profile")
    /// We together
    public static let main = Strings.tr("Localizable", "titles.main", fallback: "We together")
    /// Profile
    public static let profile = Strings.tr("Localizable", "titles.profile", fallback: "Profile")
    /// Settings
    public static let settings = Strings.tr("Localizable", "titles.settings", fallback: "Settings")
    /// Wishlist
    public static let wishlist = Strings.tr("Localizable", "titles.wishlist", fallback: "Wishlist")
  }
  public enum ValidationErrors {
    /// Invalid email format
    public static let emailFormatError = Strings.tr("Localizable", "validationErrors.emailFormatError", fallback: "Invalid email format")
    /// Email can not be empty
    public static let emptyEmail = Strings.tr("Localizable", "validationErrors.emptyEmail", fallback: "Email can not be empty")
    /// The fields should not be empty
    public static let emptyEmailAndPassword = Strings.tr("Localizable", "validationErrors.emptyEmailAndPassword", fallback: "The fields should not be empty")
    /// Password can not be empty
    public static let emptyPassword = Strings.tr("Localizable", "validationErrors.emptyPassword", fallback: "Password can not be empty")
    /// Password must contain at least 1 digit
    public static let passwordDigitError = Strings.tr("Localizable", "validationErrors.passwordDigitError", fallback: "Password must contain at least 1 digit")
    /// Password length is at least 8 characters
    public static let passwordLengthError = Strings.tr("Localizable", "validationErrors.passwordLengthError", fallback: "Password length is at least 8 characters")
    /// Passwords don't match
    public static let passwordsDontMatch = Strings.tr("Localizable", "validationErrors.passwordsDontMatch", fallback: "Passwords don't match")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
// swiftlint:enable all
