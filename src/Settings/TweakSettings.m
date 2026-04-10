#import "TweakSettings.h"

@implementation SCITweakSettings

// MARK: - Sections

+ (NSArray *)sections {
    return @[
        @{
            @"header": @"",
            @"rows": @[
                [SCISetting navigationCellWithTitle:@"Saving"
                                           subtitle:@""
                                               icon:[SCISymbol symbolWithName:@"tray.and.arrow.down"]
                                        navSections:@[@{
                                            @"header": @"",
                                            @"rows": @[
                                                [SCISetting switchCellWithTitle:@"Download feed posts" subtitle:@"Long-press with finger(s) to download posts in the home tab" defaultsKey:@"dw_feed_posts"],
                                                [SCISetting switchCellWithTitle:@"Download reels" subtitle:@"Long-press with finger(s) on a reel to download" defaultsKey:@"dw_reels"],
                                                [SCISetting switchCellWithTitle:@"Download stories" subtitle:@"Long-press with finger(s) while viewing someone's story to download" defaultsKey:@"dw_story"],
                                                [SCISetting switchCellWithTitle:@"Save profile picture" subtitle:@"On someone's profile, click their profile picture to enlarge it, then hold to download" defaultsKey:@"save_profile"]
                                            ]
                                        },
                                        @{
                                            @"header": @"Customize gestures",
                                            @"rows": @[
                                                [SCISetting stepperCellWithTitle:@"Finger count for long-press" subtitle:@"Downloads with %@ %@" defaultsKey:@"dw_finger_count" min:1 max:5 step:1 label:@"fingers" singularLabel:@"finger"],
                                                [SCISetting stepperCellWithTitle:@"Long-press hold time" subtitle:@"Press finger(s) for %@ %@" defaultsKey:@"dw_finger_duration" min:0 max:10 step:0.25 label:@"sec" singularLabel:@"sec"]
                                            ]
                                        }]
                ],
                [SCISetting navigationCellWithTitle:@"Debug"
                                           subtitle:@""
                                               icon:[SCISymbol symbolWithName:@"ladybug"]
                                        navSections:@[@{
                                            @"header": @"FLEX",
                                            @"rows": @[
                                                [SCISetting switchCellWithTitle:@"Enable FLEX gesture" subtitle:@"Allows you to hold 5 fingers on the screen to open the FLEX explorer" defaultsKey:@"flex_instagram"],
                                                [SCISetting switchCellWithTitle:@"Open FLEX on app launch" subtitle:@"Automatically opens the FLEX explorer when the app launches" defaultsKey:@"flex_app_launch"],
                                                [SCISetting switchCellWithTitle:@"Open FLEX on app focus" subtitle:@"Automatically opens the FLEX explorer when the app is focused" defaultsKey:@"flex_app_start"]
                                            ]
                                        },
                                        @{
                                            @"header": @"SCInsta",
                                            @"rows": @[
                                                [SCISetting switchCellWithTitle:@"Enable tweak settings quick-access" subtitle:@"Allows you to hold on the home tab to open the SCInsta settings" defaultsKey:@"settings_shortcut" requiresRestart:YES],
                                                [SCISetting switchCellWithTitle:@"Show tweak settings on app launch" subtitle:@"Automatically opens the SCInsta settings when the app launches" defaultsKey:@"tweak_settings_app_launch"],
                                                [SCISetting buttonCellWithTitle:@"Reset onboarding completion state"
                                                                           subtitle:@""
                                                                               icon:nil
                                                                             action:^(void) { [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SCInstaFirstRun"]; [SCIUtils showRestartConfirmation];}
                                                ],
                                            ]
                                        },
                                        @{
                                            @"header": @"Instagram",
                                            @"rows": @[
                                                [SCISetting switchCellWithTitle:@"Disable safe mode" subtitle:@"Makes Instagram not reset settings after subsequent crashes (at your own risk)" defaultsKey:@"disable_safe_mode"]
                                            ]
                                        }]
                ]
            ]
        },
        @{
            @"header": @"Credits",
            @"rows": @[
                [SCISetting linkCellWithTitle:@"Developer" subtitle:@"SoCuul" imageUrl:@"https://i.imgur.com/c9CbytZ.png" url:@"https://socuul.dev"],
                [SCISetting linkCellWithTitle:@"View Repo" subtitle:@"View the tweak's source code on GitHub" imageUrl:@"https://i.imgur.com/BBUNzeP.png" url:@"https://github.com/SoCuul/SCInsta"]
            ],
            @"footer": [NSString stringWithFormat:@"SCInsta %@\n\nInstagram v%@", SCIVersionString, [SCIUtils IGVersionString]]
        }
    ];
}


// MARK: - Title

+ (NSString *)title {
    return @"SCInsta Settings";
}


// MARK: - Menus

+ (NSDictionary *)menus {
    return @{};
}

@end
