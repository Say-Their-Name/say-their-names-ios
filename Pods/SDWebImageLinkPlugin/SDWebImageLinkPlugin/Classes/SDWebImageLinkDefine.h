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

/**
 A `LPLinkMetadata` object used to fetch image/icon for website. If you provide this value, we don't use `LPMetadataProvider` to fetch the website's metadata again, directlly use your prefetched metadata instead.
 @note If the provided `LPLinkMetadata` does not have any `imageProvider` or `iconProvider`, a error with code `SDWebImageLinkErrorNoImageProvider` will be returned. (`LPLinkMetadata`)
 */
FOUNDATION_EXPORT SDWebImageContextOption _Nonnull const SDWebImageContextLinkMetadata API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0));

/**
 A Bool value specify whether or not, to request the metadata's image, with the Data representation. But default we do not keep data by using `loadObjectOfClass` API. If enable, we'll use `loadDataRepresentationForTypeIdentifier` API instead, and decode the data into image object.
 @note Current implementation, LinkPresentation can retrive UIImage object 5x faster than the Data, so by default, we only request the image object witthout data. But it depends on your own usage, you can trun this on. (NSNumber *)
 */
FOUNDATION_EXPORT SDWebImageContextOption _Nonnull const SDWebImageContextLinkRequestImageData API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0));
