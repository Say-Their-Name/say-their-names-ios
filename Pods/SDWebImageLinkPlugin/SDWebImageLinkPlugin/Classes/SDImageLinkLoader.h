/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
@import SDWebImage;
#endif

/// A Rich Link loader by using the LinkPresentation framework, load any URL's rich link image, like Website URL, local file URL. See LinkPresentation framework description.
API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0))
@interface SDImageLinkLoader : NSObject <SDImageLoader>

/// Shared loader instance.
@property (class, readonly, nonnull) SDImageLinkLoader *sharedLoader;

/// The time interval after which the request automatically fails if it hasn’t already completed. Defaults to 30 seconds.
@property (nonatomic) NSTimeInterval timeout;

/// A Boolean value indicating whether to download subresources specified by the metadata. Defaults to YES.
@property (nonatomic) BOOL shouldFetchSubresources;

/// A Boolean valud indicating whether to fetch any video resource (like `remoteVideoURL` or `videoProvider`). Defaults to YES. Change this to NO if you don't want video resource.
@property (nonatomic) BOOL shouldfetchVideoResources;

@end
