/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import "SDImageLinkLoader.h"
#import "SDWebImageLinkDefine.h"
#import "SDWebImageLinkError.h"
#import "NSImage+SDWebImageLinkPlugin.h"
#import <LinkPresentation/LinkPresentation.h>
#if SD_UIKIT
#import <MobileCoreServices/MobileCoreServices.h>
#endif

@interface SDImageLinkLoaderOperation : NSObject <SDWebImageOperation>

@property (nonatomic, strong) LPMetadataProvider *provider;
@property (nonatomic, getter=isCancelled) BOOL cancelled;

@end

@implementation SDImageLinkLoaderOperation

- (void)cancel {
    [self.provider cancel];
    self.cancelled = YES;
}

@end

@interface SDImageLinkLoaderContext : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) SDImageLoaderProgressBlock progressBlock;

@end

@implementation SDImageLinkLoaderContext
@end

@interface SDImageLinkLoader ()

@end

@implementation SDImageLinkLoader

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeout = 30;
        self.shouldFetchSubresources = YES;
        self.shouldfetchVideoResources = YES;
    }
    return self;
}

+ (SDImageLinkLoader *)sharedLoader {
    static SDImageLinkLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[SDImageLinkLoader alloc] init];
    });
    return loader;
}

#pragma mark - SDImageLoader

- (BOOL)canRequestImageForURL:(NSURL *)url {
    return YES;
}

- (id<SDWebImageOperation>)requestImageWithURL:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    SDImageLinkLoaderOperation *operation = [SDImageLinkLoaderOperation new];
    // Let's check wether input URL already have an associated LPLinkMetadata
    LPLinkMetadata *metadata = context[SDWebImageContextLinkMetadata];
    if (metadata) {
        [self fetchImageWithMetadata:metadata operation:operation url:url options:options context:context progress:progressBlock completed:completedBlock];
    } else {
        LPMetadataProvider *provider = [[LPMetadataProvider alloc] init];
        provider.timeout = self.timeout;
        provider.shouldFetchSubresources = self.shouldFetchSubresources;
        [provider startFetchingMetadataForURL:url completionHandler:^(LPLinkMetadata * _Nullable metadata, NSError * _Nullable error) {
            if (error) {
                if (completedBlock) {
                    dispatch_main_async_safe(^{
                        completedBlock(nil, nil, error, YES);
                    });
                }
                return;
            }
            [self fetchImageWithMetadata:metadata operation:operation url:url options:options context:context progress:progressBlock completed:completedBlock];
        }];
        operation.provider = provider;
    }
    
    return operation;
}

- (void)fetchImageWithMetadata:(LPLinkMetadata *)metadata operation:(SDImageLinkLoaderOperation *)operation url:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    // Parse context option
    BOOL requestData = [context[SDWebImageContextLinkRequestImageData] boolValue];
    // Check image provider
    NSItemProvider *imageProvider = metadata.imageProvider;
    if (!imageProvider) {
        // Check icon provider as a backup
        NSItemProvider *iconProvider = metadata.iconProvider;
        if (!iconProvider) {
            // No image to query, failed
            if (completedBlock) {
                dispatch_main_async_safe(^{
                    NSError *error = [NSError errorWithDomain:SDWebImageLinkErrorDomain code:SDWebImageLinkErrorNoImageProvider userInfo:nil];
                    completedBlock(nil, nil, error, YES);
                });
            }
            return;
        }
        imageProvider = iconProvider;
    }
    if (requestData || ![imageProvider canLoadObjectOfClass:UIImage.class]) {
        // Request the image data and decode
        [self fetchImageDataWithProvider:imageProvider metadata:metadata operation:operation url:url options:options context:context progress:progressBlock completed:completedBlock];
    } else {
        // Only request the image object, faster
        [self fetchImageWithProvider:imageProvider metadata:metadata operation:operation url:url progress:progressBlock completed:completedBlock];
    }
}

// Fetch image and data with `loadDataRepresentationForTypeIdentifier` API
- (void)fetchImageDataWithProvider:(NSItemProvider *)imageProvider metadata:(LPLinkMetadata *)metadata operation:(SDImageLinkLoaderOperation *)operation url:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    SDImageLinkLoaderContext *loaderContext = [SDImageLinkLoaderContext new];
    loaderContext.url = url;
    loaderContext.progressBlock = progressBlock;
    __block NSProgress *progress;
    progress = [imageProvider loadDataRepresentationForTypeIdentifier:(__bridge NSString *)kUTTypeImage completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (progressBlock && progress) {
            [progress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) context:(__bridge void *)(loaderContext)];
        }
        if (operation.isCancelled) {
            // Cancelled
            error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:nil];
        }
        if (error) {
            if (completedBlock) {
                dispatch_main_async_safe(^{
                    completedBlock(nil, nil, error, YES);
                });
            }
            return;
        }
        // This is global queue, decode it
        UIImage *image = SDImageLoaderDecodeImageData(data, url, options, context);
        if (!image) {
            error = [NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorBadImageData userInfo:nil];
        } else {
            // The original metadata contains image data and is large, we pick the metadata info only to avoid double cache of image
            LPLinkMetadata *strippedMetadata = [self strippedMetadata:metadata];
            // Save the metadata to extended data
            image.sd_extendedObject = strippedMetadata;
        }
        if (completedBlock) {
            dispatch_main_async_safe(^{
                completedBlock(image, data, error, YES);
            });
        }
    }];
    
    if (progressBlock && progress) {
        [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionNew context:(__bridge void *)(loaderContext)];
    }
}

// Fetch image with `loadObjectOfClass` API
- (void)fetchImageWithProvider:(NSItemProvider *)imageProvider metadata:(LPLinkMetadata *)metadata operation:(SDImageLinkLoaderOperation *)operation url:(NSURL *)url progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    SDImageLinkLoaderContext *loaderContext = [SDImageLinkLoaderContext new];
    loaderContext.url = url;
    loaderContext.progressBlock = progressBlock;
    __block NSProgress *progress;
    progress = [imageProvider loadObjectOfClass:UIImage.class completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (progressBlock && progress) {
            [progress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) context:(__bridge void *)(loaderContext)];
        }
        if (operation.isCancelled) {
            // Cancelled
            error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:nil];
        }
        if (error) {
            if (completedBlock) {
                dispatch_main_async_safe(^{
                    completedBlock(nil, nil, error, YES);
                });
            }
            return;
        }
        NSAssert([image isKindOfClass:UIImage.class], @"NSItemProvider loaded object should be UIImage class");
        if (!image) {
            error = [NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorBadImageData userInfo:nil];
        } else {
            // The original metadata contains image data and is large, we pick the metadata info only to avoid double cache of image
            LPLinkMetadata *strippedMetadata = [self strippedMetadata:metadata];
            // Save the metadata to extended data
            image.sd_extendedObject = strippedMetadata;
        }
        if (completedBlock) {
            dispatch_main_async_safe(^{
                completedBlock(image, nil, error, YES);
            });
        }
    }];
    
    if (progressBlock && progress) {
        [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionNew context:(__bridge void *)(loaderContext)];
    }
}

- (BOOL)shouldBlockFailedURLWithURL:(NSURL *)url error:(NSError *)error {
    BOOL shouldBlockFailedURL = NO;
    if ([error.domain isEqualToString:SDWebImageErrorDomain]) {
        shouldBlockFailedURL = (   error.code == SDWebImageErrorInvalidURL
                                || error.code == SDWebImageErrorBadImageData);
    }
    return shouldBlockFailedURL;
}

#pragma mark - Util
- (LPLinkMetadata *)strippedMetadata:(LPLinkMetadata *)originalMetadata {
    NSCParameterAssert(originalMetadata);
    LPLinkMetadata *metadata = [LPLinkMetadata new];
    metadata.URL = originalMetadata.URL;
    metadata.originalURL = originalMetadata.originalURL;
    metadata.title = originalMetadata.title;
    if (self.shouldfetchVideoResources) {
        metadata.remoteVideoURL = originalMetadata.remoteVideoURL;
    }
    return metadata;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:NSProgress.class]) {
        SDImageLinkLoaderContext *loaderContext = (__bridge id)(context);
        if ([loaderContext isKindOfClass:SDImageLinkLoaderContext.class]) {
            NSURL *url = loaderContext.url;
            SDImageLoaderProgressBlock progressBlock = loaderContext.progressBlock;
            NSProgress *progress = object;
            if (progressBlock) {
                progressBlock(progress.completedUnitCount, progress.totalUnitCount, url);
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
