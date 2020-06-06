// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Close
  internal static let close = L10n.tr("Localizable", "close")
  /// Donations
  internal static let donations = L10n.tr("Localizable", "donations")
  /// Find Out More
  internal static let findOutMore = L10n.tr("Localizable", "find_out_more")
  /// Home
  internal static let home = L10n.tr("Localizable", "home")
  /// Petitions
  internal static let petitions = L10n.tr("Localizable", "petitions")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings")
  /// Share
  internal static let share = L10n.tr("Localizable", "share")
  /// verfied
  internal static let verified = L10n.tr("Localizable", "verified")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
