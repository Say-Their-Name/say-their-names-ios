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

FOUNDATION_EXPORT NSErrorDomain const SDWebImageLinkErrorDomain API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0));

typedef NS_ERROR_ENUM(SDWebImageLinkErrorDomain, SDWebImageLinkError) {
    /// Metadata have no any ImageProvider or IconProvider to query
    SDWebImageLinkErrorNoImageProvider = 10000,
} API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0));
