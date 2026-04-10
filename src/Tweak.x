#import <substrate.h>
#import "InstagramHeaders.h"
#import "Tweak.h"
#import "Utils.h"

///////////////////////////////////////////////////////////

// * Tweak version *
NSString *SCIVersionString = @"v1.5.0";

// Tweak first-time setup
%hook IGInstagramAppDelegate
- (_Bool)application:(UIApplication *)application willFinishLaunchingWithOptions:(id)arg2 {
    // Default SCInsta config
    NSDictionary *sciDefaults = @{
        @"dw_feed_posts": @(YES),
        @"dw_reels": @(YES),
        @"dw_story": @(YES),
        @"save_profile": @(YES),
        @"dw_finger_count": @(3),
        @"dw_finger_duration": @(0.5),
    };
    [[NSUserDefaults standardUserDefaults] registerDefaults:sciDefaults];

    return %orig;
}
- (_Bool)application:(UIApplication *)application didFinishLaunchingWithOptions:(id)arg2 {
    %orig;

    // Open settings for first-time users
    double openDelay = [SCIUtils getBoolPref:@"tweak_settings_app_launch"] ? 0.0 : 5.0;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(openDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (
            ![[[NSUserDefaults standardUserDefaults] objectForKey:@"SCInstaFirstRun"] isEqualToString:SCIVersionString]
            || [SCIUtils getBoolPref:@"tweak_settings_app_launch"]
        ) {
            NSLog(@"[SCInsta] First run, initializing");
            NSLog(@"[SCInsta] Displaying SCInsta first-time settings modal");
            [SCIUtils showSettingsVC:[self window]];
        }
    });

    NSLog(@"[SCInsta] Cleaning cache...");
    [SCIUtils cleanCache];

    return true;
}
%end

// Disable sending modded insta bug reports
%hook IGWindow
- (void)showDebugMenu {
    return;
}
%end

%hook IGBugReportUploader
- (id)initWithNetworker:(id)arg1
         pandoGraphQLService:(id)arg2
             analyticsLogger:(id)arg3
                userDefaults:(id)arg4
         launcherSetProvider:(id)arg5
shouldPersistLastBugReportId:(id)arg6
{
    return nil;
}
%end

// Disable safe mode (defaults reset upon subsequent crashes)
%hook IGSafeModeChecker
- (id)initWithInstacrashCounterProvider:(void *)provider crashThreshold:(unsigned long long)threshold {
    if ([SCIUtils getBoolPref:@"disable_safe_mode"]) return nil;

    return %orig(provider, threshold);
}
- (unsigned long long)crashCount {
    if ([SCIUtils getBoolPref:@"disable_safe_mode"]) {
        return 0;
    }

    return %orig;
}
%end
