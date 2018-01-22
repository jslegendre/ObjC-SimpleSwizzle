/***********************************************
    Compile with: clang -framework Foundation
        Or copy/paste into Xcode project
 ***********************************************/

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Class bundle = objc_getClass("NSBundle");
        class_replaceMethod(bundle, @selector(bundleIdentifier), imp_implementationWithBlock(^ {return @"com.apple.finder";}), NULL);
        NSUserNotification *n = [[NSUserNotification alloc] init];
        NSUserNotificationCenter *defCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
        n.title = @"Title";
        n.subtitle = @"Subtitle";
        n.informativeText = @"Informative Text";
        [defCenter deliverNotification:n];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];

        
        Method originalMethod = class_getInstanceMethod(object_getClass(defCenter),
                                                        sel_registerName("_notificationClickedMessage:"));

        CFURLRef iconPath = CFURLCreateWithString(NULL, CFSTR("/path/to/my/icon"), NULL);
        class_replaceMethod(object_getClass(defCenter),
                            sel_registerName("_notificationClickedMessage:"),
                            imp_implementationWithBlock(^ {
                                CFUserNotificationDisplayNotice(0, kCFUserNotificationPlainAlertLevel,
                                            iconPath, NULL, NULL, CFSTR("Clicked!"),
                                            CFSTR("Done with Private API Swizzeling"), CFSTR("OK"));
                            }),
                            method_getTypeEncoding(originalMethod));
    }
    
    return 0;
}