// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// About
  internal static let about = L10n.tr("Localizable", "about")
  /// Bookmark
  internal static let bookmark = L10n.tr("Localizable", "bookmark")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Close
  internal static let close = L10n.tr("Localizable", "close")
  /// Description
  internal static let description = L10n.tr("Localizable", "description")
  /// Donate
  internal static let donate = L10n.tr("Localizable", "donate")
  /// Donations
  internal static let donations = L10n.tr("Localizable", "donations")
  /// ALL
  internal static let filterAll = L10n.tr("Localizable", "filter_all")
  /// BUSINESSES
  internal static let filterBusinesses = L10n.tr("Localizable", "filter_businesses")
  /// PROTESTERS
  internal static let filterProtesters = L10n.tr("Localizable", "filter_protesters")
  /// VICTIMS
  internal static let filterVictims = L10n.tr("Localizable", "filter_victims")
  /// FIND OUT MORE
  internal static let findOutMore = L10n.tr("Localizable", "find_out_more")
  /// Home
  internal static let home = L10n.tr("Localizable", "home")
  /// Joing our slack group
  internal static let joinSlack = L10n.tr("Localizable", "join_slack")
  /// A massive thank you to everyone involved
  internal static let massiveThankYou = L10n.tr("Localizable", "massive_thank_you")
  /// Follow Us
    internal static let twitterFollowUs = L10n.tr("Localizable", "twitter_follow_us")
  /// Petitions
  internal static let petitions = L10n.tr("Localizable", "petitions")
  /// https://github.com/Say-Their-Name/say-their-names-ios
  internal static let repoUrl = L10n.tr("Localizable", "repo_url")
  /// Say their names
  internal static let sayTheirNames = L10n.tr("Localizable", "say_their_names")
  /// Search
  internal static let search = L10n.tr("Localizable", "search")
  /// Share
  internal static let share = L10n.tr("Localizable", "share")
  /// https://saytheirnames.slack.com/join/shared_invite/zt-eqjuatz7-fgh3zPRXIKiiXsC1Vf3oZA#/
  internal static let slackUrl = L10n.tr("Localizable", "slack_url")
  /// https://twitter.com/SayTheirName_io
  internal static let twitterUrl = L10n.tr("Localizable", "twitter_url")
  /// verified
  internal static let verified = L10n.tr("Localizable", "verified")
  /// VIEW OUR REPO
  internal static let viewRepo = L10n.tr("Localizable", "view_repo")
    
  internal enum GetInvolved {
    internal static let title = L10n.tr("Localizable", "get_involved.title")
    internal static let button = L10n.tr("Localizable", "get_involved.button")
    internal static let url = L10n.tr("Localizable", "get_involved.url")
  }
  
  internal enum GetInvolvedRepo {
    internal static let title = L10n.tr("Localizable", "get_involved_dev.title")
    internal static let button = L10n.tr("Localizable", "get_involved_dev.button")
    internal static let url = L10n.tr("Localizable", "get_involved_dev.url")
  }

  internal enum GetInvolvedTwitter {
    internal static let title = L10n.tr("Localizable", "get_involved_twitter.title")
    internal static let button = L10n.tr("Localizable", "get_involved_twitter.button")
    internal static let url = L10n.tr("Localizable", "get_involved_twitter.url")
  }
    
  internal enum GetInvolvedDesign {
    /// HOW DO I GET INVOLVED AS A DESIGNER?
    internal static let title = L10n.tr("Localizable", "get_involved_design.title")
  }

  internal enum GetInvolvedDev {
    /// HOW DO I GET INVOLVED AS A DEVELOPER?
    internal static let title = L10n.tr("Localizable", "get_involved_dev.title")
  }

  internal enum MoreHistory {
    /// About the project title
    internal static let aboutTitle = L10n.tr("Localizable", "more_history.title")
    /// About the project
    internal static let aboutDesc = L10n.tr("Localizable", "more_history_desc")
  }

  internal enum Person {
    /// Age
    internal static let age = L10n.tr("Localizable", "person.age")
    /// Children
    internal static let children = L10n.tr("Localizable", "person.children")
    /// Social Media Hashtags
    internal static let hashtags = L10n.tr("Localizable", "person.hashtags")
    /// Location
    internal static let location = L10n.tr("Localizable", "person.location")
    /// Media
    internal static let media = L10n.tr("Localizable", "person.media")
    /// News
    internal static let news = L10n.tr("Localizable", "person.news")
    /// Outcome
    internal static let outcome = L10n.tr("Localizable", "person.outcome")
    /// Say their names
    internal static let sayTheirNames = L10n.tr("Localizable", "person.say_their_names")
    /// Their Story
    internal static let theirStory = L10n.tr("Localizable", "person.their_story")
  }
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
