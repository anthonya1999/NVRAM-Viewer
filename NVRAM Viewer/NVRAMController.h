//
//  NVRAMController.h
//  NVRAM Viewer
//
//  Created by Anthony Agatiello on 1/28/21.
//

#import <Foundation/Foundation.h>

@interface NVRAMController : NSObject

+ (id)getNVRAMVariable:(NSString *)name;
+ (NSString *)bytesToString:(NSData *)data;

@end
