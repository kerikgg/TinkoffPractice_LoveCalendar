// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Buttons {
    /// Localizable.strings
    ///   LoveCalendar
    /// 
    ///   Created by kerik on 16.04.2024.
    public static let signIn = Strings.tr("Localizable", "buttons.signIn", fallback: "Sign In")
    /// Sign Up
    public static let signUp = Strings.tr("Localizable", "buttons.signUp", fallback: "Sign Up")
  }
  public enum Labels {
    /// Sign In
    public static let signInLabel = Strings.tr("Localizable", "labels.signInLabel", fallback: "Sign In")
    /// Sign Up
    public static let signUpLabel = Strings.tr("Localizable", "labels.signUpLabel", fallback: "Sign Up")
  }
  public enum TextFields {
    /// Email
    public static let emailPlaceholder = Strings.tr("Localizable", "textFields.emailPlaceholder", fallback: "Email")
    /// Password confirmation
    public static let passwordConfirmationPlaceholder = Strings.tr("Localizable", "textFields.passwordConfirmationPlaceholder", fallback: "Password confirmation")
    /// Password
    public static let passwordPlaceholder = Strings.tr("Localizable", "textFields.passwordPlaceholder", fallback: "Password")
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
