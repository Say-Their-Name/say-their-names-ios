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

#if SD_MAC
API_AVAILABLE(macos(10.15))
/// Make NSImage supports the `NSItemProviderReading` as well as UIKit's UIImage
@interface NSImage (SDWebImageLinkPlugin) <NSItemProviderReading, NSItemProviderWriting>

@end

#endif
