/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import "NSImage+SDWebImageLinkPlugin.h"

#if SD_MAC

@implementation NSImage (SDWebImageLinkPlugin)

#pragma mark - NSItemProviderReading

+ (instancetype)objectWithItemProviderData:(NSData *)data typeIdentifier:(NSString *)typeIdentifier error:(NSError *__autoreleasing  _Nullable *)outError {
    return [[NSImage alloc] initWithData:data];
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    return [NSImage imageTypes];
}

#pragma mark - NSItemProviderWriting

+ (NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    return @[(__bridge NSString *)kUTTypeTIFF,
             (__bridge NSString *)kUTTypePNG,
             (__bridge NSString *)kUTTypeJPEG,
             (__bridge NSString *)kUTTypeJPEG2000,
             (__bridge NSString *)kUTTypeBMP,
             (__bridge NSString *)kUTTypeGIF];
}

- (nullable NSProgress *)loadDataWithTypeIdentifier:(nonnull NSString *)typeIdentifier forItemProviderCompletionHandler:(nonnull void (^)(NSData * _Nullable, NSError * _Nullable))completionHandler {
    NSRect imageRect = NSMakeRect(0, 0, self.size.width, self.size.height);
    NSImageRep *imageRep = [self bestRepresentationForRect:imageRect context:nil hints:nil];
    NSBitmapImageRep *bitmapImageRep;
    if ([imageRep isKindOfClass:[NSBitmapImageRep class]]) {
        bitmapImageRep = (NSBitmapImageRep *)imageRep;
    } else {
        bitmapImageRep = [[NSBitmapImageRep alloc] initWithCGImage:self.CGImage];
    }
    NSBitmapImageFileType fileType = NSBitmapImageFileTypeTIFF; // Defaults to TIFF
    if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeTIFF]) {
        fileType = NSBitmapImageFileTypeTIFF;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypePNG]) {
        fileType = NSBitmapImageFileTypePNG;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeJPEG]) {
        fileType = NSBitmapImageFileTypeJPEG;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeJPEG2000]) {
        fileType = NSBitmapImageFileTypeJPEG2000;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeBMP]) {
        fileType = NSBitmapImageFileTypeBMP;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeGIF]) {
        fileType = NSBitmapImageFileTypeGIF;
    }
    NSData *imageData = [bitmapImageRep representationUsingType:fileType properties:@{}];
    if (completionHandler) {
        completionHandler(imageData, nil);
    }
    
    return nil;
}

@end

#endif
