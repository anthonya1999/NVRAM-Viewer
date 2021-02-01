//
//  NVRAMController.m
//  NVRAM Viewer
//
//  Created by Anthony Agatiello on 1/28/21.
//

#import "NVRAMController.h"

@implementation NVRAMController

static kern_return_t GetOFVariable(char *name, CFStringRef *nameRef, CFTypeRef *valueRef) {
    *nameRef = CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingUTF8);
    if (*nameRef == 0) {
        printf("Error creating CFString for key %s", name);
        return kIOReturnError;
    }
    
    mach_port_t masterPort = MACH_PORT_NULL;
    IOMasterPort(bootstrap_port, &masterPort);
    io_registry_entry_t options = IORegistryEntryFromPath(masterPort, "IODeviceTree:/options");
    *valueRef = IORegistryEntryCreateCFProperty(options, *nameRef, 0, 0);
    if (*valueRef == 0) {
        return kIOReturnNotFound;
    }
    
    return KERN_SUCCESS;
}

+ (id)getNVRAMVariable:(NSString *)name {
    CFStringRef nameOut = NULL;
    CFTypeRef valueOut = NULL;
    kern_return_t error = GetOFVariable((char *)[name UTF8String], &nameOut, &valueOut);
    if (error || !valueOut) {
        return nil;
    }
    
    // Toll-free bridge CFTypeRef to Objective-C object
    // (This is usually NSData but not guaranteed)
    return (__bridge id)valueOut;
}

+ (NSString *)bytesToString:(NSData *)data {
    NSMutableString *result = [NSMutableString string];
    const char *bytes = [data bytes];
    for (int i = 0; i < [data length]; i++) {
        [result appendFormat:@"%02hhx", (unsigned char)bytes[i]];
    }
    return [result copy];
}

@end
