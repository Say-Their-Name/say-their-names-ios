/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "LPLinkView+WebCache.h"
#import "SDWebImageLinkDefine.h"

static inline NSString *SDBase64DecodedString(NSString *base64String) {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (!data) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

static inline void SDLinkMetadataSetImage(LPLinkMetadata *metadata, UIImage *image) {
    static Class LPImageClass;
    static SEL initWithPlatformImageSEL;
    if (!LPImageClass) {
        LPImageClass = NSClassFromString(SDBase64DecodedString(@"TFBJbWFnZQ=="));
        if (!LPImageClass) {
            return;
        }
    }
    if (!initWithPlatformImageSEL) {
        initWithPlatformImageSEL = NSSelectorFromString(SDBase64DecodedString(@"aW5pdFdpdGhQbGF0Zm9ybUltYWdlOg=="));
        if (!initWithPlatformImageSEL) {
            return;
        }
    }
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id linkImage = [[LPImageClass alloc] performSelector:initWithPlatformImageSEL withObject:image];
    #pragma clang diagnostic pop
    @try {
        [metadata setValue:linkImage forKey:@"image"];
    } @catch (NSException *exception) {
        NSLog(@"SDLinkMetadataSetImage error with exception: %@", exception);
    }
}

@implementation LPLinkView (WebCache)

- (void)sd_setImageWithURL:(nullable NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options context:(nullable SDWebImageContext *)context {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options context:context progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options progress:(nullable SDImageLoaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options context:nil progress:progressBlock completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                   context:(nullable SDWebImageContext *)context
                  progress:(nullable SDImageLoaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock {
    
    __weak typeof(self) wself = self;
    [self sd_internalSetImageWithURL:url placeholderImage:placeholder options:options context:context setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong typeof(self) sself = wself;
        LPLinkMetadata *metadata = context[SDWebImageContextLinkMetadata];
        if (metadata) {
            // Already exist
        } else if (image) {
            id extendedObject = image.sd_extendedObject;
            // Re-generate the metadata from local information
            if ([extendedObject isKindOfClass:LPLinkMetadata.class]) {
                metadata = extendedObject;
            } else {
                metadata = [[LPLinkMetadata alloc] init];
                metadata.originalURL = url;
                metadata.URL = imageURL;
            }
            // Create a new UIImage to avoid retain cycle
            #if SD_MAC
            UIImage *platformImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:image.scale orientation:kCGImagePropertyOrientationUp];
            #else
            UIImage *platformImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:image.scale orientation:image.imageOrientation];
            #endif
            // LPLinkMetadata.imageProvider on iOS 13.1 contains bug which cause async query, and not compatible for cell-reusing.
            // Here we have to use image instead of imageProvider, Radar FB7462933
            SDLinkMetadataSetImage(metadata, platformImage);
        } else {
            metadata = [[LPLinkMetadata alloc] init];
            metadata.originalURL = url;
            metadata.URL = imageURL;
        }
        sself.metadata = metadata;
    } progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType, imageURL);
        }
    }];
}

@end
