// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum STNAsset {
  internal enum Color {
    internal static let actionButton = ColorAsset(name: "actionButton")
    internal static let actionButtonTint = ColorAsset(name: "actionButtonTint")
    internal static let background = ColorAsset(name: "background")
    internal static let black = ColorAsset(name: "black")
    internal static let cellBackground = ColorAsset(name: "cellBackground")
    internal static let darkGray = ColorAsset(name: "darkGray")
    internal static let detailLabel = ColorAsset(name: "detailLabel")
    internal static let gray = ColorAsset(name: "gray")
    internal static let inverse = ColorAsset(name: "inverse")
    internal static let lightHeader = ColorAsset(name: "lightHeader")
    internal static let navBarBackground = ColorAsset(name: "navBarBackground")
    internal static let navBarForeground = ColorAsset(name: "navBarForeground")
    internal static let primaryLabel = ColorAsset(name: "primaryLabel")
    internal static let searchBarText = ColorAsset(name: "searchBarText")
    internal static let secondaryLabel = ColorAsset(name: "secondaryLabel")
    internal static let separator = ColorAsset(name: "separator")
    internal static let strongHeader = ColorAsset(name: "strongHeader")
    internal static let tabBarBarTint = ColorAsset(name: "tabBarBarTint")
    internal static let tabBarBorder = ColorAsset(name: "tabBarBorder")
    internal static let tabBarTint = ColorAsset(name: "tabBarTint")
    internal static let tabBarUnselectedItemTint = ColorAsset(name: "tabBarUnselectedItemTint")
    internal static let white = ColorAsset(name: "white")
  }
  internal enum Image {
    internal static let like = ImageAsset(name: "Like")
    internal static let stnLogoBlaock = ImageAsset(name: "STN_logo_blaock")
    internal static let stnLogoWhite = ImageAsset(name: "STN_logo_white")
    internal static let arrowLeft = ImageAsset(name: "arrow_left")
    internal static let arrowRight = ImageAsset(name: "arrow_right")
    internal static let bookmark = ImageAsset(name: "bookmark")
    internal static let bookmarkActive = ImageAsset(name: "bookmark_active")
    internal static let bookmarkWhite = ImageAsset(name: "bookmark_white")
    internal static let close = ImageAsset(name: "close")
    internal static let gallery = ImageAsset(name: "gallery")
    internal static let galleryActive = ImageAsset(name: "gallery_active")
    internal static let heart = ImageAsset(name: "heart")
    internal static let heartActive = ImageAsset(name: "heart_active")
    internal static let newsBbc = ImageAsset(name: "news_bbc")
    internal static let petition = ImageAsset(name: "petition")
    internal static let petitionActive = ImageAsset(name: "petition_active")
    internal static let search = ImageAsset(name: "search")
    internal static let searchVector = ImageAsset(name: "search_vector")
    internal static let searchWhite = ImageAsset(name: "search_white")
    internal static let settings = ImageAsset(name: "settings")
    internal static let settingsActive = ImageAsset(name: "settings_active")
    internal static let shareDark = ImageAsset(name: "share_dark")
    internal static let shareWhite = ImageAsset(name: "share_white")
    internal static let twitterLogo = ImageAsset(name: "twitter_logo")
    internal static let userCircle = ImageAsset(name: "user_circle")
    internal static let livesMatter = ImageAsset(name: "lives_matter")
    internal static let manInRedJacket = ImageAsset(name: "man_in_red_jacket")
    internal static let mediaImage1 = ImageAsset(name: "media_image_1")
    internal static let mediaImage2 = ImageAsset(name: "media_image_2")
    internal static let placeholder = ImageAsset(name: "placeholder")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
